//
//  RootTabBarControllerViewModel.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import Combine
import UIKit


protocol RootTabBarControllerViewModel {
    var selectedItem: CurrentValueSubject<Int, Never> { get }
    var openChooseCityVC: PassthroughSubject<UIViewController, Never> { get }
    func updateWeaherInfo(by coordinate: Coordinate, isFirst: Bool)
    func getTabBarViewModel() -> TabBarViewModel
    func getCityViewModel() -> CityViewModel
    
}

class RootTabBarControllerViewModelImpl: RootTabBarControllerViewModel {
    var selectedItem = CurrentValueSubject<Int, Never>(0)
    var openChooseCityVC = PassthroughSubject<UIViewController, Never>()
    
    
    private var bag = Set<AnyCancellable>()
    private let tabBarViewModel: TabBarViewModel = TabBarViewModelImpl()
    private let weatherManager: WeatherManager = WeatherManagerImpl.instance
    private let cityViewModel: CityViewModel = CityViewModelImpl()
    
    // MARK: - Init
    init() {
        subscribe()
    }
    // MARK: - Subscribe
    private  func subscribe() {
        tabBarViewModel.selectItemOut
            .subscribe(selectedItem)
            .store(in: &bag)
        selectedItem
            .subscribe(tabBarViewModel.selectItemIn)
            .store(in: &bag)
        
        weatherManager.currentForecastInfo.sink { [weak self] info in
            self?.cityViewModel.updateIn.send(info?.city)
        }.store(in: &bag)
        cityViewModel.changeCityOut
            .sink { [weak self] _ in
                self?.openChooseVC()
            }.store(in: &bag)
    }
    // MARK: - Public Methods
    func getTabBarViewModel() -> TabBarViewModel {
        return tabBarViewModel
    }
    
    func updateWeaherInfo(by coordinate: Coordinate, isFirst: Bool) {
        weatherManager.getForecastWeatherByCoordinate(by: coordinate, isFirst: isFirst)
    }
    
    func getCityViewModel() -> CityViewModel {
        return cityViewModel
    }
    // MARK: - Private Methods
    private func openChooseVC() {
        let controller = ControllersFactory.instance.getChooseLocationVC(with: weatherManager.location)
        openChooseCityVC.send(controller)
    }
}
