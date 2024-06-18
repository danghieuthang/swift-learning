//
//  CoreDataProvider.swift
//  TodoAppWithCoreData
//
//  Created by Thắng Đặng on 6/18/24.
//

import CoreData
import Foundation

class CoreDataProvider {
    let persistentContainer: NSPersistentContainer

    static var preview: CoreDataProvider = {
        let provider = CoreDataProvider(inMemory: true)
        let viewContext = provider.persistentContainer.viewContext
        for index in 1 ..< 10 {
            let todoItem = TodoItem(context: viewContext)
            todoItem.title = "Title \(index)"
            todoItem.isCompleted = index % 2 == 0
        }
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
        return provider
    }()

    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "TodoAppWithCoreData")

        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data store failed to initialize \(error)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
