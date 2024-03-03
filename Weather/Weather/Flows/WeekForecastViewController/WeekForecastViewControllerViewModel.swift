//
//  WeekForecastViewControllerViewModel.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import Combine
import UIKit


protocol WeekForecastViewControllerViewModel {
    var isLoading: Bool { get }
    var weatherInfoes: [WeatherInfo] { get }
    var reload: PassthroughSubject<Void, Never> { get }
}

class WeekForecastViewControllerViewModelImpl: WeekForecastViewControllerViewModel {
    var isLoading = true
    var weatherInfoes: [WeatherInfo] = []
    var reload = PassthroughSubject<Void, Never>()
    private var bag = Set<AnyCancellable>()
    private let weatherManager: WeatherManager = WeatherManagerImpl.instance
    
    init() {
        subscribe()
    }
    
    private func subscribe() {
        weatherManager.currentForecastInfo.sink { [weak self] forecast in
            if let forecast = forecast {
                self?.isLoading = false
                self?.weatherInfoes = Array(forecast.weatherInfoes[0...6])
            } else {
                self?.weatherInfoes = []
                self?.isLoading = true
            }
           
            self?.reload.send()
        }.store(in: &bag)
    }
}


