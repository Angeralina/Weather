//
//  WeekForecastViewController.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import Combine
import UIKit

class WeekForecastViewController: UIViewController {
    // MARK: - Private properties
    private let tableView = UITableView()
    private let viewModel: WeekForecastViewControllerViewModel = WeekForecastViewControllerViewModelImpl()
    private let sizes = Adaptation.shared
    private let dateFormatter = DateFormatter()
    private var bag = Set<AnyCancellable>()

    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        subscribe()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    // MARK: - Configuration
    private func configure() {
        dateFormatter.dateFormat = "EEE"
        configureBackImage()
        configureTableView()
    }
    private func configureBackImage() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "back"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = CGRect(x: sizes.forecastTableViewSide, y: sizes.forecastTableViewTop, width: sizes.forecastTableViewWidth, height: sizes.forecastTableViewHeight)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(
            UINib(nibName: ForecatTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ForecatTableViewCell.identifier
        )
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    // MARK: - Subscribe
    private func subscribe() {
        viewModel.reload.sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &bag)
    }

}


extension WeekForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isLoading ? 1 : viewModel.weatherInfoes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sizes.forecastTableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(
            withIdentifier: ForecatTableViewCell.identifier,
            for: indexPath) as? ForecatTableViewCell
        guard let cell = reusableCell
        else { return UITableViewCell() }
        if  viewModel.isLoading {
            cell.loadConfigure()
        } else {
            let info = viewModel.weatherInfoes[indexPath.row]
            let date = indexPath.row == 0 ? "Today" : dateFormatter.string(from: info.date)
            cell.confugure(info, date: date)
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
