//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/10/24.
//

import SwiftUI

struct BudgetDetailView: View {
    let budgetCategory: BudgetCategory
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    HStack {
                        Text("Budget: ")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }.fontWeight(.bold)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
}
