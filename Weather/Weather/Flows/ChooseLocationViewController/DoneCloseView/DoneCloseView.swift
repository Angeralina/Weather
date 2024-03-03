//
//  DoneCloseView.swift
//  Weather
//
//  Created by Алина on 03.03.2024.
//

import Combine
import UIKit

protocol DoneCloseViewModel {
    var closeOut: PassthroughSubject<Bool, Never> { get set }
}

class DoneCloseViewModelImpl: DoneCloseViewModel {
    var closeOut = PassthroughSubject<Bool, Never>()
}

class DoneCloseView: UIView {
    
    // MARK: - IBOutlets

   
    // MARK: - Private properties
    private let viewModel: DoneCloseViewModel
    private var bag = Set<AnyCancellable>()

    // MARK: - Init
    init(_ viewModel: DoneCloseViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        // swiftlint:disable force_cast
        let view = UINib(nibName: "DoneCloseView", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
    }


    @IBAction func close(_ sender: Any) {
        viewModel.closeOut.send(false)
    }
    
    
    @IBAction func done(_ sender: Any) {
        viewModel.closeOut.send(true)
    }
    
}

