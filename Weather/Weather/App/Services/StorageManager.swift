//
//  StorageManager.swift
//  Weather
//
//  Created by Алина on 03.03.2024.
//

import Foundation

protocol StorageManager {
    func save(_ forecast: Data)
    func getForecast() -> Data? 
}
class StorageManagerImpl: StorageManager {
    private let userDefaults = UserDefaults.standard
    private let forecastKey = "forecastKey"
    
    func save(_ forecastData: Data) {
        if let JSONString = String(data: forecastData, encoding: String.Encoding.utf8) {
            userDefaults.set(JSONString, forKey: forecastKey)
        }
        
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(forecastData) {
//            userDefaults.set(encoded, forKey: forecastKey)
//        }
    }
    
    func getForecast() -> Data? {
        if  let JSONString = userDefaults.string(forKey: forecastKey) {
            return JSONString.data(using: .utf8)
        } else {
            return nil
        }
    }
}
