//
//  AddCoffeeView.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/6/24.
//

import SwiftUI

struct AddCoffeeErrors {
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
}

struct AddCoffeeView: View {
    var order: Order? = nil
    @State var name: String = ""
    @State var coffeeName: String = ""
    @State var price: String = ""
    @State var size: CoffeeSize = .medium
    @State private var errors: AddCoffeeErrors = .init()

    @EnvironmentObject private var model: CoffeeModel

    @Environment(\.dismiss) private var dismiss

    /// Just UI Validation, not business rule
    var isValid: Bool {
        errors = AddCoffeeErrors()

        if name.isEmpty {
            errors.name = "Name cannot be empty!"
        }

        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee Name cannot be empty!"
        }

        if price.isEmpty {
            errors.price = "Price cannot be empty!"
        } else if !price.isNumeric {
            errors.price = "Price needs to be a number"
        } else if price.isLessThan(1) {
            errors.price = "Price need to be more than 0"
        }

        return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.price.isEmpty
    }

    private func placeOrder(_ order: Order) async {
        do {
            try await model.placeOrder(order)
        } catch {
            print(error)
        }
    }

    private func updateOrder(_ order: Order) async {
        do {
            try await model.updateOrder(order)
        } catch {
            print(error)
        }
    }

    private func populateExistingOrder() {
        if let order = order {
            name = order.name
            coffeeName = order.coffeeName
            price = String(order.total)
            size = order.size
        }
    }

    private func saveOrUpdate() async {
        if let order {
            var editOrder = order
            editOrder.name = name
            editOrder.total = Double(price) ?? 0
            editOrder.coffeeName = coffeeName
            editOrder.size = size
            await updateOrder(editOrder)
        } else {
            let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: size)
            await placeOrder(order)
        }
        dismiss()
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                Text(errors.name).visible(errors.name.isNotEmpty)
                    .font(.caption)
                TextField("Coffee name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty)
                    .font(.caption)
                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")
                Text(errors.price).visible(errors.price.isNotEmpty)
                    .font(.caption)
                Picker("Select size", selection: $size) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }.pickerStyle(.segmented)

                Button(order != nil ? "Update Order" : "Place Order") {
                    if isValid {
                        Task {
                            await saveOrUpdate()
                        }
                    }
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
            }.navigationTitle(order != nil ? "Update Order" : "Add Coffee")
                .onAppear {
                    populateExistingOrder()
                }
        }
    }
}

#Preview {
    AddCoffeeView()
}
