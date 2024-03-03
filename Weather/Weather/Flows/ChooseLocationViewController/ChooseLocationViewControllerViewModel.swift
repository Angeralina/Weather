//
//  ChooseLocationViewControllerViewModel.swift
//  Weather
//
//  Created by Алина on 03.03.2024.
//

import Combine
import UIKit


protocol ChooseLocationVCViewModel {
    var doneCloseViewModel: DoneCloseViewModel { get }
    func updateLocation(by coordinate: Coordinate)
}

class ChooseLocationVCViewModelImpl: ChooseLocationVCViewModel {
    let doneCloseViewModel: DoneCloseViewModel = DoneCloseViewModelImpl()
    private let weatherManager = WeatherManagerImpl.instance
    
    func updateLocation(by coordinate: Coordinate) {
        weatherManager.getForecastWeatherByCoordinate(by: coordinate, isFirst: false)
    }
}


