//
//  Expenses.swift
//  iExpense
//
//  Created by Benjamin van den Hout on 12/10/2023.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
