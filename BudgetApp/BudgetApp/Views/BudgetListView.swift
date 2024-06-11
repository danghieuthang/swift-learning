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
                    NavigationLink(value: budgetCategory) {
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                Text("\(budgetCategory.overSpent ? "Overspent" : "Remainning") \(Text(budgetCategory.remainningBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundColor(budgetCategory.overSpent ? .red : .green)
                            }
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
        }.navigationDestination(for: BudgetCategory.self, destination: { budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        })
    }
}
