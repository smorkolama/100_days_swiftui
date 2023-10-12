//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Benjamin van den Hout on 12/10/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID() // Needs to be var to fix 'Immutable property will not be decoded because it is declared with an initial value which cannot be overwritten'
    let name: String
    let type: String
    let amount: Double
}
