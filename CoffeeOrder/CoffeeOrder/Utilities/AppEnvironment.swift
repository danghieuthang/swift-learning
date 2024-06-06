//
//  AppEnvironment.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/5/24.
//

import Foundation

enum Endpoints {
    case allOrders
    case placeOrder
    case deleteOrder(Int)
    case updateOrder(Int)
    var path: String {
        switch self {
        case .allOrders:
            return "orders"
        case .placeOrder:
            return "orders"
        case .deleteOrder(let orderId):
            return "orders/\(orderId)"
        case .updateOrder(let orderId):
            return "orders"
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        if env == "TEST" {
            return AppEnvironment.test
        }
        return AppEnvironment.dev
    }()
}

enum AppEnvironment: String {
    case dev
    case test
    var baseUrl: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me")!
        }
    }
}
