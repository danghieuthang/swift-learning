//
//  WebService.swift
//  MVVM
//
//  Created by Thắng Đặng on 6/4/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badRequest
    case decodingError
}

class WebService {
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw NetworkError.badUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.badUrl
        }
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            throw NetworkError.decodingError
        }
        return products
    }
}
