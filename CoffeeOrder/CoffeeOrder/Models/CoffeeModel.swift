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

    func orderById(_ id: Int) -> Order? {
        guard let index = orders.firstIndex(where: {
            $0.id == id
        }) else {
            return nil
        }
        return orders[index]
    }

    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webService.placeOrder(order: order)
        orders.append(newOrder)
    }

    func populateOrders() async throws {
        orders = try await webService.getOrders()
    }

    func updateOrder(_ order: Order) async throws {
        let updateOrder = try await webService.updateOder(order: order)
        guard let index = orders.firstIndex(where: {
            $0.id == updateOrder.id
        }) else {
            return
        }
        orders[index] = updateOrder
    }

    func deleteOrder(_ orderId: Int) async throws {
        let isDeleted = try await webService.deleteOrder(orderId: orderId)
        if isDeleted {
            orders = orders.filter {
                $0.id != orderId
            }
        }
    }
}
