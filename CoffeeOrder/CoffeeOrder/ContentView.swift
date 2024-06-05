//
//  ContentView.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/5/24.
//

import SwiftUI

struct ContentView: View {
    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }

    @EnvironmentObject private var model: CoffeeModel
    var body: some View {
        VStack {
            List(model.orders) { order in
                OrderCellView(order: order)
            }
        }.task {
            await populateOrders()
        }
    }
}



#Preview {
    ContentView()
        .environmentObject(CoffeeModel(webService: WebService()))
}
