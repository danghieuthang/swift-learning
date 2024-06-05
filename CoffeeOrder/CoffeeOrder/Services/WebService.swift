//
//  WebService.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/5/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case badRequest
}

class WebService {
    private var baseUrl: URL
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    func getOrders() async throws -> [Order] {
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseUrl) else {
            throw NetworkError.badUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }

        return orders
    }
}
