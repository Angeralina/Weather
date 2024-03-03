//
//  MainViewControllerViewModel.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import Combine
import UIKit


protocol MainViewControllerViewModel {
   func getContentViewModel() -> MainControllerContentViewModel
   
}

class MainViewControllerViewModelImpl: MainViewControllerViewModel {
    
    private let weatherManager: WeatherManager = WeatherManagerImpl.instance
    
    private let contentViewModel: MainControllerContentViewModel = MainControllerContentViewModelImpl()
    private var bag = Set<AnyCancellable>()
    init() {
        subscribe()
    }
    
    private func subscribe() {
        weatherManager.currentForecastInfo.sink { [weak self] forecast in
            self?.contentViewModel.updateIn.send(forecast?.weatherInfoes.first)
        }.store(in: &bag)
    }
    
   
    
    func getContentViewModel() -> MainControllerContentViewModel {
        return contentViewModel
    }
    
    
}

