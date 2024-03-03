//
//  WeatherManager.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import Combine
import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
    
    init() {
        latitude = 50.0
        longitude = 50.0
    }
    
    init(lat: Double, lon: Double) {
        latitude = lat
        longitude = lon
    }
}

protocol WeatherManager {
    func getForecastWeatherByCoordinate(by coordinate: Coordinate, isFirst: Bool)
    var currentForecastInfo: CurrentValueSubject<ForecastInfo?, Never> { get }
    var location: Coordinate { get }
}

class WeatherManagerImpl: WeatherManager {
    
    // MARK: API KEY
    private let weatherAPIKey = "9be8d24ee1fbb28bb13943f6e5add515"
    
    var location: Coordinate = Coordinate()
    var currentForecastInfo = CurrentValueSubject<ForecastInfo?, Never>(nil)
    
    static let instance = WeatherManagerImpl()
    
    
    private let storageManager: StorageManager = StorageManagerImpl()
    // MARK: Init
    private init() { }
    
    
    func getForecastWeatherByCoordinate(by coordinate: Coordinate, isFirst: Bool) {
        currentForecastInfo.send(nil)
        let parameters: [String: Any] = [
            "lat" : "\(coordinate.latitude)",
            "lon" : "\(coordinate.longitude)",
            "appid" : weatherAPIKey
        ]
                
        let request = APIRequest(method: .get,
                                 path: BasePath.current,
                                 queryItems: parameters
        )
        
        APICenter().perform(urlString: BaseURL.weatherURL,
                            request: request
        ) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                if isFirst, let data = response.body {
                    self.storageManager.save(data)
                }
                if let response = try? response.decode(to: SevenDayWeather.self) {
                    let forecastInfo = ForecastInfo(by: response.body, coordinate: coordinate)
                    self.location = coordinate
                    
                    DispatchQueue.main.async {
                        self.currentForecastInfo.send(forecastInfo)
                    }
                } else {
                    print(APIError.decodingFailed)
                    self.tryGetStoredData(by: coordinate)
                }
            case .failure:
                print(APIError.networkFailed)
                self.tryGetStoredData(by: coordinate)
            }
        }
    }
    
    private func tryGetStoredData(by coordinate: Coordinate) {
        if let data = storageManager.getForecast() {
//                    if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
//                       print(JSONString)
//                    }
            let decoder = JSONDecoder()
            if let response = try? decoder.decode(SevenDayWeather.self, from: data) {
                let forecastInfo = ForecastInfo(by: response, coordinate: coordinate)
                self.location = coordinate
                DispatchQueue.main.async {
                    self.currentForecastInfo.send(forecastInfo)
                }
            } else {
                print(APIError.decodingFailed)
            }
        } else {
            print(APIError.dataFailed)
        }
        
    }
}
