//
//  ContentView.swift
//  TodoAppWithCoreData
//
//  Created by Thắng Đặng on 6/18/24.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<TodoItem>

    @State private var title: String = ""

    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }

    private func saveTodoItem() {
        let dotoItem = TodoItem(context: context)
        dotoItem.title = title
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    private var pendingTaskItems: [TodoItem] {
        todoItems.filter { !$0.isCompleted }
    }

    private var completedTaskItems: [TodoItem] {
        todoItems.filter { $0.isCompleted }
    }

    private func updateTodoItem(_ todoItem: TodoItem) {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    private func deleteTodoItem(_ todoItem: TodoItem) {
        context.delete(todoItem)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    if isFormValid {
                        saveTodoItem()
                    }
                }
            List {
                Section("Pending") {
                    if pendingTaskItems.isEmpty {
                        ContentUnavailableView("No Items found.", image: "doc")
                    } else {
                        ForEach(pendingTaskItems) { todoItem in
                            TodoCellView(todoItem: todoItem, onChanged: updateTodoItem)
                        }.onDelete(perform: { indexSet in
                            for index in indexSet {
                                let todoItem = pendingTaskItems[index]
                                deleteTodoItem(todoItem)
                            }

                        })
                    }
                }

                Section("Completed") {
                    ForEach(completedTaskItems) { todoItem in
                        TodoCellView(todoItem: todoItem, onChanged: updateTodoItem)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Todo")
    }
}

struct TodoCellView: View {
    let todoItem: TodoItem
    let onChanged: (TodoItem) -> Void
    var body: some View {
        HStack {
            Image(systemName: todoItem.isCompleted ? "checkmark.square" : "square")
                .onTapGesture {
                    todoItem.isCompleted = !todoItem.isCompleted
                    onChanged(todoItem)
                }
            if todoItem.isCompleted {
                Text(todoItem.title ?? "")
            } else {
                TextField("", text: Binding(get: {
                    todoItem.title ?? ""
                }, set: { newValue in
                    todoItem.title = newValue
                })).onSubmit {
                    onChanged(todoItem)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView().environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
