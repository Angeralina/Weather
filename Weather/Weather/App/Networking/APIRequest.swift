//
//  APIRequest.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import Foundation

// MARK: APIRequest
struct APIRequest {
    let method: HTTPMethod
    var path: String?
    var queryItems: [String: Any]?
    var headers: [HTTPHeader]?
    var body: Data?
    
    init(method: HTTPMethod) {
        self.method = method
    }

    init(method: HTTPMethod, path: String, queryItems: [String: Any]) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
    }
    
    init<Body: Encodable>(method: HTTPMethod, path: String, body: Body) throws {
        self.method = method
        self.path = path
        self.body = try? JSONEncoder().encode(body)
    }
}

