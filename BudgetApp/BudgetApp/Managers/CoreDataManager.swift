//
//  CoreDataManager.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/9/24.
//

import CoreData
import Foundation

class CoreDataManager {
    static let share = CoreDataManager()
    private var persistentContainer : NSPersistentContainer
    /// Make it private so nobody else can be initialize
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores{ description, error in
            if let error{
                fatalError("Unable to initialize Core data stack \(error)")
            }
        }
    
    }
    /// Property return the NS ManagedObjectContext, which can access from the persistent container
    var viewContext: NSManagedObjectContext{
        persistentContainer.viewContext
    }
}
