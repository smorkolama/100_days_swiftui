//
//  ContentViewExamples.swift
//  WeSplit
//
//  Created by Benjamin van den Hout on 26/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    
    let currencyStyle: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var totalPerPerson: Double {
        // UI starts at 2, so 0 corresponds to 2 people. Off by two
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalPerCheck: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyStyle)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }

                Section {
                    Text(totalPerCheck, format: currencyStyle)
                    // exercise from day 23, https://www.hackingwithswift.com/books/ios-swiftui/views-and-modifiers-wrap-up
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount of the check")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyStyle)
                } header: {
                    Text("Amount to pay per person")
                }

            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer() // Pushes button to the right

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
