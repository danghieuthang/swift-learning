//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/10/24.
//

import CoreData
import SwiftUI

struct BudgetDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String = ""
    @State private var total: String = ""
    let budgetCategory: BudgetCategory

    var isFormValid: Bool {
        guard let totalAsDouble = Double(total) else {
            return false
        }
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }

    private func saveTransaction() {
        do {
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total)!

            budgetCategory.addToTransactions(transaction)
            try viewContext.save()
            
            title = ""
            total = ""
        } catch {
            print(error)
        }
    }

    private func deleteTransaction(_ transaction: Transaction) {
        viewContext.delete(transaction)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }

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
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                } header: {
                    Text("Add Transaction")
                }
                HStack {
                    Spacer()
                    Button("Save Transaction") {
                        saveTransaction()
                    }.disabled(!isFormValid)
                        .buttonStyle(.bordered)
                    Spacer()
                }
            }.frame(maxHeight: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
                .padding([.bottom], 20)
            VStack {
                BudgetSummaryView(budgetCategory: budgetCategory)
                // Dispolay summarty of the budget category
                // Dipslay transaction
                TransactionListView(request: BudgetCategory.transactionsByCategoryResquest(budgetCategory), onDeleteTransaction: deleteTransaction)
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
}
