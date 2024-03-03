//
//  TabBarViewModel.swift
//  Weather
//
//  Created by Алина on 01.03.2024.
//

import Combine
import Foundation


protocol TabBarViewModel {
    var selectItemOut: PassthroughSubject<Int, Never> { get }
    var selectItemIn: PassthroughSubject<Int, Never> { get }
}

class TabBarViewModelImpl: TabBarViewModel {
    var selectItemOut = PassthroughSubject<Int, Never>()
    var selectItemIn = PassthroughSubject<Int, Never>()
}
