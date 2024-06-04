//
//  StoreModel.swift
//  MVPattern
//
//  Created by Thắng Đặng on 6/4/24.
//

import Foundation

// Ensure that code marked with it runs on the main thread
@MainActor
class StoreModel: ObservableObject {
    @Published var products: [Product] = []
    let webService: WebService
    init(webService: WebService) {
        self.webService = webService
    }

    func populateProducts() async throws {
        products = try await webService.getProducts()
    }
}
