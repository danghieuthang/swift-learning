//
//  ContentView.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }

    private func deleteOrder(_ indexSet: IndexSet) {
        for index in indexSet {
            let deleteOrder = model.orders[index]

            guard let orderId = deleteOrder.id else {
                return
            }
            Task {
                do {
                    try await model.deleteOrder(orderId)
                } catch {
                    print(error)
                }
            }
        }
    }

    @EnvironmentObject private var model: CoffeeModel
    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!").accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(model.orders) { order in
                            NavigationLink(value: order.id) {
                                OrderCellView(order: order)
                            }
                        }.onDelete(perform: deleteOrder)
                    }
                }
            }
            .navigationDestination(for: Int.self, destination: { orderId in
                OrderDetailView(orderId: orderId)
            })
            .task {
                await populateOrders()
            }
            .sheet(isPresented: $isPresented, content: {
                AddCoffeeView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add New Order") {
                        isPresented = true
                    }.accessibilityIdentifier("addNewOrderButton")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        ContentView()
            .environmentObject(CoffeeModel(webService: WebService(baseUrl: config.environment.baseUrl)))
    }
}
