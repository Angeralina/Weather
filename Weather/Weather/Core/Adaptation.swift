//
//  Adaptation.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import UIKit

struct Adaptation {
    
    // MARK: - Main
    var contentTop: CGFloat = 230.0

    // MARK: - TabBar
    private var cityViewTop: CGFloat = 60.0
    private var cityViewRight: CGFloat = 25.0
    private var cityViewSize: CGSize = CGSize(width: 288.0, height: 55.0)
    var cityFrame = CGRect.zero
    
    private var tabBarViewHeight: CGFloat = 100.0
    private var tabBarViewYPos: CGFloat = 0.0
    var tabBarViewFrame = CGRect .zero
    // MARK: - Forecast
    var forecastTableViewTop: CGFloat = 125.0
    var forecastTableViewSide: CGFloat = 25.0
    var forecastTableViewWidth: CGFloat = 300.0
    var forecastTableViewHeight: CGFloat = 500.0
    var forecastTableViewCellHeight: CGFloat = 66.0
    
    // MARK: - Map
    
    private var doneCloseViewHeight: CGFloat = 120.0
    var doneCloseViewFrame = CGRect.zero
    var markImageViewFrame = CGRect.zero
    
    static let shared = Adaptation()
    private init() {
        updateConstraints()
    }
    
    mutating private func updateConstraints() {
        let size = UIScreen.main.bounds.size

        switch size.height {
        case 568.0, 667.0, 736.0:
            cityViewTop = 10.0
            tabBarViewHeight = 80.0
            forecastTableViewTop = 65.0
            doneCloseViewHeight = 70.0
            contentTop = 170.0
//        case 812.0: // 12
//        case 852: // 14 pro

//        case  896.0: // XR
//        case 926.0: // 12max
//        case 932.0: // 14 pro max
//        case 1000.0...: // , ipads
//
        default: // 812.0: XS, 844.0
           break
        }
        tabBarViewYPos = size.height - tabBarViewHeight
        forecastTableViewWidth = size.width - (forecastTableViewSide * 2.0)
        tabBarViewFrame = CGRect( x: 0.0,
                                      y: tabBarViewYPos,
                                      width: size.width,
                                      height: tabBarViewHeight)
        let cityLeft = size.width - cityViewRight - cityViewSize.width
        cityFrame = CGRect(origin: CGPoint(x: cityLeft, y: cityViewTop), size: cityViewSize)
        
        doneCloseViewFrame = CGRect(origin: .zero, size: CGSize(width: size.width, height: doneCloseViewHeight))
        markImageViewFrame = CGRect(x: (size.width - 35.0) / 2.0,
                                    y: (size.height - 70.0) / 2.0,
                                    width: 35.0,
                                    height: 35.0)
    }
}

