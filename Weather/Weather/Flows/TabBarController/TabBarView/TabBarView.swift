//
//  TabBarView.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import Combine
import UIKit


class TabBarView: UIView {
   
    
    // MARK: - Private properties
    private let viewModel: TabBarViewModel
    
    private let mainItemView = TabBarItemView()
    private let forecastItemView  = TabBarItemView()
    private var bag = Set<AnyCancellable>()
    // MARK: - Init
    init(frame: CGRect, viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configure()
        subscribe() 
        setSelectedUI(by: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Configuration
    private func configure() {
        adaptation()
        backgroundColor = .clear
        isUserInteractionEnabled = true
        addItemViews()
    }
    
    
    private func addItemViews() {
        addSubview(mainItemView)
        addSubview(forecastItemView)
        let itemFrame = CGRect(x: itemSpace, y: itemViewTop, width: itemViewWidth, height: itemViewHeight)
        mainItemView.configure(frame: itemFrame, title: "Main", tag: 0)
        forecastItemView.configure(frame: itemFrame, title: "Forecast", tag: 1)
        
        mainItemView.delegate = self
        forecastItemView.delegate = self
    }
    
    // MARK: - Subscribe
    private func subscribe() {
        viewModel.selectItemIn.sink { [weak self] index in
            self?.setSelectedUI(by: index)
        }.store(in: &bag)
    }
    
    // MARK: - private methods
    private func setSelectedUI(by selectedIndex: Int) {
        let isMain =  selectedIndex == self.mainItemView.tag
        self.mainItemView.isSelected = isMain
        self.forecastItemView.isSelected = !isMain
        UIView.animate(withDuration: 0.25) {
            self.mainItemView.frame.origin.x = isMain
            ? self.centerItemXPosition : self.leftItemXPosition
            self.forecastItemView.frame.origin.x = !isMain
            ? self.centerItemXPosition : self.rightItemXPosition
        }
    }
    
    // MARK: - Adaptation
    
    private var centerItemXPosition: CGFloat = 0.0
    private var leftItemXPosition: CGFloat = 0.0
    private var rightItemXPosition: CGFloat = 0.0
    
    private var itemSpace: CGFloat = 0.0
    private let itemViewWidth: CGFloat = 115.0
    private let itemViewHeight: CGFloat = 50.0
    private let itemViewTop: CGFloat = 0.0
    
    private func adaptation() {
        let itemSpace = (frame.width - (itemViewWidth * 3.0)) / 4.0
        leftItemXPosition = itemSpace
        centerItemXPosition = (frame.width - itemViewWidth) / 2.0
        rightItemXPosition = centerItemXPosition + itemViewWidth + itemSpace
    }

}

// MARK: - TabBarItemViewDelegate
extension TabBarView: TabBarItemViewDelegate {
    func itemTapped(tag: Int) {
        viewModel.selectItemOut.send(tag)
    }

}

