//
//  ContentView.swift
//  MVVM
//
//  Created by Thắng Đặng on 6/4/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ProductListViewModel(webservice: WebService())
    var body: some View {
        VStack {
            List(vm.products) { product in
                Text(product.title)
            }.task {
                await vm.populateProducts()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
