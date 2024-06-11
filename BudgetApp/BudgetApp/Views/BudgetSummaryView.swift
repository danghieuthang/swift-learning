//
//  BudgetSummaryView.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/11/24.
//

import SwiftUI

struct BudgetSummaryView: View {
    @ObservedObject var budgetCategory: BudgetCategory
    var body: some View {
        VStack {
            Text("\(budgetCategory.overSpent ? "Overspent" : "Remainning") \(Text(budgetCategory.remainningBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundColor(budgetCategory.overSpent ? .red : .green)
        }
    }
}
