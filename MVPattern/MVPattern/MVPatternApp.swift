//
//  MVPatternApp.swift
//  MVPattern
//
//  Created by Thắng Đặng on 6/4/24.
//

import SwiftUI

@main
struct MVPatternApp: App {
    @StateObject private var storeModel = StoreModel(webService: WebService())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storeModel)
        }
    }
}
