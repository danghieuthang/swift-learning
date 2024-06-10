//
//  BudgetCategory+CoreDataExtensions.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/9/24.
//

import CoreData
import Foundation

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    override public func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
