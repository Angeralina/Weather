//
//  Configuration.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import UIKit

class Configuration {
    
    static let tabBarButtonColor = #colorLiteral(red: 0.5411764706, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
    static let tabBarSelectColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let tabBarDeselectColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    static func getIconImage(by name: String) -> UIImage {
        switch name {
        case "01d" :
            return #imageLiteral(resourceName: "sun")
        case "01n":
            return #imageLiteral(resourceName: "sun")
        case "02d" :
            return #imageLiteral(resourceName: "cloudy-day")
        case "02n":
            return #imageLiteral(resourceName: "cloudy-day")
        case "03d" :
            return #imageLiteral(resourceName: "cloud")
        case "03n":
            return #imageLiteral(resourceName: "cloud")
        case "04d" :
            return #imageLiteral(resourceName: "cloud")
        case "04n":
            return #imageLiteral(resourceName: "cloud")
        case "09d" :
            return #imageLiteral(resourceName: "rainy")
        case "09n":
            return #imageLiteral(resourceName: "rainy")
        case "10d" :
            return #imageLiteral(resourceName: "rainy")
        case "10n":
            return #imageLiteral(resourceName: "rainy")
        case "11d" :
            return #imageLiteral(resourceName: "thunderstorm")
        case "11n":
            return #imageLiteral(resourceName: "thunderstorm")
        case "13d" :
            return #imageLiteral(resourceName: "snowflake")
        case "13n":
            return #imageLiteral(resourceName: "snowflake")
        case "50d" :
            return #imageLiteral(resourceName: "cloud")
        case "50n":
            return #imageLiteral(resourceName: "cloud")
        default:
            return #imageLiteral(resourceName: "cloudy-day")
        }
    }
}


