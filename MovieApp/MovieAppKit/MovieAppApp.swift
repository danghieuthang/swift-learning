//
//  MovieAppKitApp.swift
//  MovieAppKit
//
//  Created by Thắng Đặng on 6/17/24.
//

import SwiftUI

@main
struct MovieAppKitApp: App {
    @StateObject private var storeModel = StoreModel(webService: WebService())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storeModel)
        }
    }
}
