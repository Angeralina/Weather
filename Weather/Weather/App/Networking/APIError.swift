//
//  APIError.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import Foundation

// MARK: APIError
enum APIError: LocalizedError {
    case invalidURL
    case requestFailed
    case networkFailed
    case decodingFailed
    case dataFailed
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "invalidURL"
        case .requestFailed:
            return "requestFailed"
        case .networkFailed:
            return "networkFailed"
        case .decodingFailed:
            return "decodingFailed"
        case .dataFailed:
            return "dataFailed"
        }
    }
}
