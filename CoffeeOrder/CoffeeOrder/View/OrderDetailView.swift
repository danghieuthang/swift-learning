//
//  OrderDetailView.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/6/24.
//

import SwiftUI

struct OrderDetailView: View {
    let orderId: Int
    @EnvironmentObject private var model: CoffeeModel
    @State private var isPresented: Bool = false
    var body: some View {
        VStack {
            if let order = model.orderById(orderId) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(order.coffeeName)
                        .font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .accessibilityIdentifier("coffeeNameText")
                    Text(order.size.rawValue)
                        .opacity(0.5)
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                    HStack {
                        Spacer()
                        Button("Delete Order", role: .destructive) {}
                        Button("Edit Order") {
                            isPresented = true
                        }
                        Spacer()
                    }
                }.sheet(isPresented: $isPresented, content: {
                    AddCoffeeView()
                })
            }
            Spacer()
        }.padding()
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        OrderDetailView(orderId: 2)
            .environmentObject(CoffeeModel(webService: WebService(baseUrl: config.environment.baseUrl)))
    }
}
