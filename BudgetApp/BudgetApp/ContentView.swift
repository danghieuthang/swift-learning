//
//  ContentView.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/9/24.
//

import CoreData
import SwiftUI

enum SheetAction: Identifiable {
    case add
    case edit(_ budgetCategory: BudgetCategory)
    var id: Int {
        switch self {
        case .add:
            return 1
        case .edit:
            return 2
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var isPresented: Bool = false
    @State private var sheetAction: SheetAction? = nil
    var total: Double {
        var res: Double = 0
        for budgetCategory in budgetCategoryResults {
            res += budgetCategory.total
        }
        return res
    }

    private func deleteBudget(_ budgetCategory: BudgetCategory) {
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }

    private func editBudget(_ budgetCategory: BudgetCategory) {
        sheetAction = .edit(budgetCategory)
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                BudgetListView(budgetCategoryResults: budgetCategoryResults,
                               onDeleteBudgetCategory: deleteBudget,
                               onEditBudgetCategory: editBudget)
            }
            .sheet(item: $sheetAction, content: { sheetAction in
                switch sheetAction {
                case .add:
                    AddBudgetCategoryView()
                case .edit(let bugetCategory):
                    AddBudgetCategoryView(budgetCategory: bugetCategory)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        sheetAction = .add
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.share.viewContext)
}
