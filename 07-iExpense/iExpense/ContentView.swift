//
//  ContentView.swift
//  iExpense
//
//  Created by Benjamin van den Hout on 12/10/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    @AppStorage("currency") private var userCurency = "EUR"

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text(item.amount, format: .currency(code: userCurency))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddExpense.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }

                ToolbarItem(placement: .bottomBar) {
                    Menu {
                        Button("Euro") {
                            userCurency = "EUR"
                        }
                        Button("Dollar") {
                            userCurency = "USD"
                        }
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses, userCurency: userCurency)
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
