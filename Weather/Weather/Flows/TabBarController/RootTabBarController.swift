//
//  RootTabBarController.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//
//
//  RootTabBarController.swift
//  BloodPressureDiary
//
//  Created by maxim on 15/11/2019.
//  Copyright © 2019 lifeasplay. All rights reserved.
//

import Combine
import MapKit
import UIKit

class RootTabBarController: UITabBarController {
    // MARK: - Private properties
    private let viewModel: RootTabBarControllerViewModel = RootTabBarControllerViewModelImpl()
    private let locationManager: CLLocationManager = CLLocationManager()
    private let sizes = Adaptation.shared
    private var bag = Set<AnyCancellable>()
    
    private let goSettingsView = GoSettingsView()
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        view.isUserInteractionEnabled = true
        configure()
        subscribe()
        
        locationManager.delegate = self
        getCoordinate()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    // MARK: - Configuration
    private func configure() {
        configureTabBarView()
        configureCityView()
        configureGoSettingsView()
    }
    private func configureTabBarView() {
        let tabBarView = TabBarView(frame: sizes.tabBarViewFrame, viewModel: viewModel.getTabBarViewModel())
        view.addSubview(tabBarView)
    }
    
    private func configureCityView() {
        let cityView = CityView(viewModel.getCityViewModel())
        cityView.frame = sizes.cityFrame
        view.addSubview(cityView)
    }
    
    private func configureGoSettingsView() {
        goSettingsView.frame = view.bounds
        view.addSubview(goSettingsView)
    }

    // MARK: - Subscribe
    private func subscribe() {
        viewModel.selectedItem.sink { [weak self] index in
            self?.selectedIndex = index
        }.store(in: &bag)
        viewModel.openChooseCityVC.sink { [weak self] controller in
            self?.openChooseCityController(controller)
        }.store(in: &bag)
    }
    // MARK: - Private methods
    private func getCoordinate() {
        locationManager.requestWhenInUseAuthorization()
    }

   

    // MARK: - Navigation
    
    private func openChooseCityController(_ controller: UIViewController) {
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}

// MARK: CLLocationManagerDelegate
extension RootTabBarController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            guard let myCurrentLocation = locationManager.location else {
                return
            }
            goSettingsView.isHidden = true
            viewModel.updateWeaherInfo(by: Coordinate(lat: myCurrentLocation.coordinate.latitude.makeRound(), lon: myCurrentLocation.coordinate.longitude.makeRound()), isFirst: true)
        case .denied:
            goSettingsView.isHidden = false
        default:
            break
        }
    }
}


