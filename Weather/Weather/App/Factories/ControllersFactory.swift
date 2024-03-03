//
//  ControllersFactory.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import UIKit

class ControllersFactory {
    
    static let instance = ControllersFactory()
    private init() { }
    
    private let chooseLocationViewController = ChooseLocationViewController()
    // MARK: - RootTabBarController
    func tabBarController() -> RootTabBarController {
        let rootTabBarController = RootTabBarController()
        rootTabBarController.viewControllers = [
            createMainViewController(),
            createForecastViewController()
        ]
        rootTabBarController.modalPresentationStyle = .fullScreen
        return rootTabBarController
    }
    func getChooseLocationVC(with coordinate: Coordinate) -> UIViewController {
        chooseLocationViewController.setMapLocation(by: coordinate)
        return chooseLocationViewController
    }
    
    private func createMainViewController() -> UIViewController {
        let controller = MainViewController()
        return controller
    }
    private func createForecastViewController() -> UIViewController {
        let controller = WeekForecastViewController()
        return controller
    }
}
