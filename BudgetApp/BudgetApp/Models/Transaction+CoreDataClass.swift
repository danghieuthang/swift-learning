//
//  Transaction+CoreDataClass.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/10/24.
//

import CoreData
import Foundation

@objc(Transaction)
public class Transaction: NSManagedObject {
    override public func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
