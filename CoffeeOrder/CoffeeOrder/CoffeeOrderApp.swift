//
//  CoffeeOrderApp.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/5/24.
//

import SwiftUI

@main
struct CoffeeOrderApp: App {
    @StateObject private var model: CoffeeModel
    init() {
        let webService = WebService()
        _model = StateObject(wrappedValue: CoffeeModel(webService: webService))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
