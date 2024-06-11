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
        dateCreated = Date()
    }

    var overSpent: Bool {
        remainningBudgetTotal < 0
    }

    var transactionsTotal: Double {
        transactionsArray.reduce(0) { result, transaction in
            result + transaction.total
        }
    }

    var remainningBudgetTotal: Double {
        total - transactionsTotal
    }

    private var transactionsArray: [Transaction] {
        guard let transactions = transactions else {
            return []
        }
        let allTransactions = (transactions.allObjects as? [Transaction] ?? [])
        return allTransactions.sorted { t1, t2 in
            t1.dateCreated! > t2.dateCreated!
        }
    }

    static func transactionsByCategoryResquest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        return request
    }
}
