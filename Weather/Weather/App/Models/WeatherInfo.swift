//
//  WeatherInfo.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import UIKit

struct ForecastInfo {
    let coordinate: Coordinate
    let city: String
    var weatherInfoes: [WeatherInfo] = []
    init(by info: SevenDayWeather, coordinate: Coordinate) {
        self.coordinate = coordinate
        city = info.city.name
        var date = Date()
        info.list.forEach { wInfo in
            let newWInfo = WeatherInfo(by: wInfo, date: date)
            weatherInfoes.append(newWInfo)
            date =  Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
        }
    }
}

struct WeatherInfo {
    let date: Date
    let degValue: Double
    let dicription: String
    let icon: UIImage
    
    init(by info: List, date: Date) {
        self.date = date
        degValue = info.main.temp.makeCelsius()
        if let weather =  info.weather.first {
            dicription = weather.description
            icon = Configuration.getIconImage(by: weather.icon)
        } else {
            dicription = "Sunny"
            icon = #imageLiteral(resourceName: "cloudy-day")
        }
    }
}


// MARK: SevenDayWeather
struct SevenDayWeather: Codable {
    let list: [List]
    let city: City
}
// MARK: City
struct City: Codable {
    let name: String
}

// MARK: List
struct List: Codable {
    let main: SevenMain
    let weather: [SevenWeather]
}

struct SevenMain: Codable {
    let temp: Double
}

// MARK: SevenWeather
struct SevenWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
