//
//  MainViewController.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//


import Combine
import UIKit

class MainViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel: MainViewControllerViewModel = MainViewControllerViewModelImpl()
    private var bag = Set<AnyCancellable>()

    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentView()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    // MARK: - Configuration
    private func configureContentView() {
        let contentView = MainControllerContentView(viewModel.getContentViewModel())
        contentView.frame = view.bounds
        view.addSubview(contentView)
    }
}

