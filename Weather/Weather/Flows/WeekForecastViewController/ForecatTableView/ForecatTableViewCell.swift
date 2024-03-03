//
//  ForecatTableViewCell.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import UIKit



class ForecatTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var degLabel: UILabel!
    @IBOutlet weak var bodyView: UIView!

    // MARK: - Public properties
    static let identifier = "ForecatTableViewCell"
    
    // MARK: - Private properties
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bodyView.roundCorners(radius: 15.0)
        
    }
    
    // MARK: - Configuration
    
    func confugure(_ info: WeatherInfo, date: String) {
        iconImageView.image = info.icon
        degLabel.text = String(format: "%.0f", arguments: [info.degValue])
        dateLabel.text = date
    }
    func loadConfigure() {
        iconImageView.image = nil
        degLabel.text = "--"
        dateLabel.text = "Loading..."
    }
}

