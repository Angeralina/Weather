//
//  TabBarItemView.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import UIKit

protocol TabBarItemViewDelegate: AnyObject {
    func itemTapped(tag : Int)
}


class TabBarItemView: UIView {
    
    weak var delegate: TabBarItemViewDelegate?
    
    var isSelected = false {
        didSet {
            setState()
        }
    }
    private let label = UILabel()
   
    
    init() {
        super.init(frame: .zero)
        addRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func configure(frame: CGRect, title: String, tag: Int) {
        self.frame = frame
        self.tag = tag
        addSubview(label)
        roundCorners(radius: 25.0)
        label.frame = CGRect(origin: .zero, size: frame.size)
        label.text = title
        label.font = UIFont(name: "SFProRounded-Medium", size: 20.0)
        label.textAlignment = .center
    }
    
    private func addRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.itemTap(_:)))
        addGestureRecognizer(recognizer)
    }
    
    @objc func itemTap(_ sender: UITapGestureRecognizer) {
        delegate?.itemTapped(tag: tag)
    }
    
    
    private func setState() {
        label.textColor = isSelected ? Configuration.tabBarSelectColor : Configuration.tabBarDeselectColor
        backgroundColor = isSelected ? Configuration.tabBarButtonColor : .clear
    }
}
