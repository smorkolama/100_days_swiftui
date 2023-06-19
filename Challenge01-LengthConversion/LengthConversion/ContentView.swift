//
//  ContentView.swift
//  LengthConversion
//
//  Created by Benjamin van den Hout on 30/08/2022.
//

import SwiftUI


struct ContentView: View {
    @FocusState private var inputIsFocussed: Bool
    
    @State private var inputValue: Double = 10.0
    private var units = ["Meter", "Kilometer", "Feet", "Mile"]
    @State private var inputUnit = "Meter"
    @State private var outputUnit = "Meter"
    
    var inputInMeters: Double {
        switch inputUnit {
        case "Meter":
            return inputValue
        case "Kilometer":
            return inputValue * 1000
        case "Feet":
            return inputValue * 0.3048
        case "Mile":
            return inputValue * 1609.344
        default:
            return -1
        }
    }
    
    var outputValue: Double {
        switch outputUnit {
        case "Meter":
            return inputInMeters
        case "Kilometer":
            return inputInMeters / 1000
        case "Feet":
            return inputInMeters / 0.3048
        case "Mile":
            return inputInMeters / 1609.344
        default:
            return -1
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Distance", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocussed)
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Input")
                }
                
                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(outputValue, format: .number)
                    
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Distances by Smork 👹")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer() // Pushes button to the right
                    
                    Button("Done") {
                        inputIsFocussed = false
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
