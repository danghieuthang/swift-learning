//
//  TodoAppWithCoreDataApp.swift
//  TodoAppWithCoreData
//
//  Created by Thắng Đặng on 6/18/24.
//

import SwiftUI

@main
struct TodoAppWithCoreDataApp: App {
    let provider = CoreDataProvider()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, provider.viewContext)
        }
    }
}
