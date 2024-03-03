//
//  UIView+roundCorners.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat?){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = (radius != nil) ? radius! : self.bounds.height / 2.0
    }
}

