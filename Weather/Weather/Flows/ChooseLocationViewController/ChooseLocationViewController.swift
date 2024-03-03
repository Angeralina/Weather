//
//  ChooseLocationViewController.swift
//  Weather
//
//  Created by Алина on 03.03.2024.
//

import Combine
import MapKit
import UIKit

class ChooseLocationViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel: ChooseLocationVCViewModel = ChooseLocationVCViewModelImpl()
    private let sizes = Adaptation.shared
    private var bag = Set<AnyCancellable>()
    private let mapView = MKMapView()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        configureDoneCloseView()
        sibscribe()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    // MARK: - Configuration
    private func configureMapView() {
        mapView.frame = view.bounds
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        let redMarkImageView = UIImageView(image:  UIImage(systemName: "mappin"))
        redMarkImageView.tintColor = .red
        redMarkImageView.frame = sizes.markImageViewFrame
        view.addSubview(redMarkImageView)
    }
    
    private func configureDoneCloseView() {
        let doneCloseView = DoneCloseView(viewModel.doneCloseViewModel)
        doneCloseView.frame = sizes.doneCloseViewFrame
        view.addSubview(doneCloseView)
    }
    
    // MARK: - Subscribe
    private func sibscribe() {
        viewModel.doneCloseViewModel.closeOut.sink { [weak self] isDone in
            self?.close(isDone)
        }.store(in: &bag)
    }
    
    private func close(_ isDone: Bool) {
        if isDone {
            let location = Coordinate(lat: mapView.centerCoordinate.latitude.makeRound(), lon: mapView.centerCoordinate.longitude.makeRound())
            viewModel.updateLocation(by: location)
        }
        dismiss(animated: true)
    }
    
    func setMapLocation(by coordinate: Coordinate) {
        let centerCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, 
                                                      longitude: coordinate.longitude)
        let region = MKCoordinateRegion( center: centerCoordinate, latitudinalMeters: CLLocationDistance(exactly: 30000)!, longitudinalMeters: CLLocationDistance(exactly: 30000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
}
