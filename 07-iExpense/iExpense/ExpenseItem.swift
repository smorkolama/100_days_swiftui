//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Benjamin van den Hout on 12/10/2023.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
