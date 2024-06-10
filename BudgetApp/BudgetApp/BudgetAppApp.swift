//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/9/24.
//

import SwiftUI

@main
struct BudgetAppApp: App {
    var body: some Scene {
        WindowGroup {
            // This particular manageobjectcontext can be accessed in the all the childrens that are part of content view
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.share.viewContext)
        }
    }
}
