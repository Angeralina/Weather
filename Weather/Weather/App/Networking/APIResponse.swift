//
//  APIResponse.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//

import Foundation

//MARK: APIResult
enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}

//MARK: APIResponse
struct APIResponse<Body> {
    let statusCode: Int
    let body: Body
}

//MARK: APIResponse Extension
extension APIResponse where Body == Data? {
    func decode<T: Decodable>(to type: T.Type) throws -> APIResponse<T> {
        guard let data = body else {
            throw APIError.dataFailed
        }
//        if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
//           print(JSONString)
//        }
        guard let decodedJSON = try? JSONDecoder().decode(T.self, from: data) else {
            throw APIError.decodingFailed
        }
        return APIResponse<T>(statusCode: self.statusCode, body: decodedJSON)
    }
}
