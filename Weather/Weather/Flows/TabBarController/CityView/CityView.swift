//
//  CityView.swift
//  Weather
//
//  Created by Алина on 03.03.2024.
//
import Combine
import UIKit

protocol CityViewModel {
    var updateIn: PassthroughSubject<String?, Never> { get }
    var changeCityOut: PassthroughSubject<Void, Never> { get }
}

class CityViewModelImpl: CityViewModel {
    var updateIn = PassthroughSubject<String?, Never>()
    var changeCityOut = PassthroughSubject<Void, Never>()
    init() {
    }
}

class CityView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cityLabel: UILabel!
   
    // MARK: - Private properties
    private let viewModel: CityViewModel
    private var bag = Set<AnyCancellable>()

    // MARK: - Init
    init(_ viewModel: CityViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        // swiftlint:disable force_cast
        let view = UINib(nibName: "CityView", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        addRecognizer(to: view)
        subscribe()
    }


    // MARK: - Subscribe
    private func subscribe() {
        viewModel.updateIn.sink { [weak self] city in
            self?.update(by: city)
        }.store(in: &bag)
        
    }
    // MARK: - Private methodth
    private func update(by city: String?) {
        cityLabel.text = city ?? "- -"
        cityLabel.sizeToFit()
    }
    
    private func addRecognizer(to view: UIView) {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTap(_:)))
        view.addGestureRecognizer(recognizer)
    }
    
    @objc func viewTap(_ sender: UITapGestureRecognizer) {
        viewModel.changeCityOut.send()
    }
}
