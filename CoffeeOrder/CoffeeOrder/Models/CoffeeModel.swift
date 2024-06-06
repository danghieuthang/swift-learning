//
//  CoffeeModel.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/5/24.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    let webService: WebService
    @Published private(set) var orders: [Order] = []
    init(webService: WebService) {
        self.webService = webService
    }

    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webService.placeOrder(order: order)
        orders.append(newOrder)
    }

    func populateOrders() async throws {
        orders = try await webService.getOrders()
    }
}
