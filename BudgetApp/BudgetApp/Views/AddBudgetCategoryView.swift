//
//  AddBudgetCategoryView.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/10/24.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    @State private var title: String = ""
    @State private var total: Double = 100
    @State private var messages: [String] = []
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    private var budgetCategory: BudgetCategory?
    init(budgetCategory: BudgetCategory? = nil) {
        self.budgetCategory = budgetCategory
    }

    var isFormValid: Bool {
        messages = []
        if title.isEmpty {
            messages.append("Title is required")
        }
        if total <= 0 {
            messages.append("Total should be greater than 1")
        }
        return messages.count == 0
    }

    private func save() {
        let budgetCategory = BudgetCategory(context: viewContext)
        budgetCategory.title = title
        budgetCategory.total = total
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func update() {
        if let budgetCategory {
            do {
                let budget = BudgetCategory.byId(budgetCategory.objectID)
                budget.title = title
                budget.total = total
                try viewContext.save()
                dismiss()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func saveOrUpdate() {
        if let budgetCategory {
            update()
        } else {
            save()
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                Slider(value: $total, in: 0 ... 500, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text("$0")
                } maximumValueLabel: {
                    Text("$500")
                }
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .center)

                ForEach(messages, id: \.self) { message in
                    Text(message)
                }
            }
            .onAppear {
                if let budgetCategory {
                    title = budgetCategory.title ?? ""
                    total = budgetCategory.total
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            saveOrUpdate()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddBudgetCategoryView()
        .environment(\.managedObjectContext, CoreDataManager.share.viewContext)
}
