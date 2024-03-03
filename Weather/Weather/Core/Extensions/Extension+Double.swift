//
//  Extension+Double.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import Foundation

//MARK: Extension+Double
extension Double {
    // kelvin to celsius
    func makeCelsius() -> Double {
        let argue = self - 273.15
        return argue
    }
    // rounding double to 2 decimal place
    func makeRound() -> Double {
        return (self * 100).rounded() / 100
    }
}
