//
//  MainControllerContentView.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import Combine
import UIKit

protocol MainControllerContentViewModel {
    var updateIn: PassthroughSubject<WeatherInfo?, Never> { get }
}

class MainControllerContentViewModelImpl: MainControllerContentViewModel {
    
    var updateIn = PassthroughSubject<WeatherInfo?, Never>()
    
    init() {
    }
}

class MainControllerContentView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var degLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var minusView: UIView!
    @IBOutlet weak var weatherIconImageView: UIImageView!

  
    
    
    // MARK: - Private properties
    private let viewModel: MainControllerContentViewModel
    private var bag = Set<AnyCancellable>()

    // MARK: - Init
    init(_ viewModel: MainControllerContentViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        // swiftlint:disable force_cast
        let view = UINib(nibName: "MainControllerContentView", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        configure()
        subscribe()
        updateConstraintsForDevice()
    }
    // MARK: - Configuration
    private func configure() {
        minusView.roundCorners(radius: 2.0)
    }
    // MARK: - Subscribe
    private func subscribe() {
        viewModel.updateIn.sink { [weak self] info in
            self?.update(by: info)
        }.store(in: &bag)
        
    }
    // MARK: - Private methodth
    private func update(by info: WeatherInfo?) {
        if let info = info {
            let degAbs = abs(info.degValue)
            degLabel.text =  String(format: "%.0f", arguments: [degAbs])
            degLabel.sizeToFit()
            minusView.isHidden = degAbs > 0
            discriptionLabel.text = info.dicription
            weatherIconImageView.image = info.icon
        } else {
            degLabel.text = "--"
            minusView.isHidden = true
            discriptionLabel.text = "Loading..."
        }
    }
    
    @IBOutlet weak var contentTop: NSLayoutConstraint!
    
    private func updateConstraintsForDevice() {
        let sizes = Adaptation.shared
        contentTop.constant = sizes.contentTop
    }

}


