//
//  BudgetListView.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/10/24.
//

import SwiftUI

struct BudgetListView: View {
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    var body: some View {
        List {
            if !budgetCategoryResults.isEmpty {
                ForEach(budgetCategoryResults) { budgetCategory in
                    HStack {
                        Text(budgetCategory.title ?? "")
                        Spacer()
                        VStack {
                            Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.map {
                        budgetCategoryResults[$0]
                    }.forEach(onDeleteBudgetCategory)
                })
            } else {
                Text("No budget categories exist.")
            }
        }
    }
}
