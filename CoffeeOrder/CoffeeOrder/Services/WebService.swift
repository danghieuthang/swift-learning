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

    func placeOrder(order: Order) async throws -> Order {
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseUrl) else {
            throw NetworkError.badUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }

//        guard let newOrder = try? JSONDecoder().decode(Order.self, from: data) else {
//            throw NetworkError.decodingError
//        }

        return order
    }

    func getOrders() async throws -> [Order] {
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseUrl) else {
            throw NetworkError.badUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        print(String(data: data, encoding: .utf8))
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }

        return orders
    }
}
