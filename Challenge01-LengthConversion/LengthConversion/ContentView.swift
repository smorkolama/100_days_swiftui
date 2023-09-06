//
//  ContentView.swift
//  LengthConversion
//
//  Created by Benjamin van den Hout on 30/08/2022.
//

import SwiftUI


struct ContentView: View {

    enum LengthUnit: String, CaseIterable {
        case meter = "Meter"
        case kilometer = "Kilometer"
        case feet = "Feet"
        case mile = "Mile"
    }

    @FocusState private var inputIsFocussed: Bool
    
    @State private var inputValue: Double = 10.0
    @State private var inputUnit: LengthUnit = .meter
    @State private var outputUnit: LengthUnit = .meter
    
    var inputInMeters: Double {
        switch inputUnit {
        case .meter:
            return inputValue
        case .kilometer:
            return inputValue * 1000
        case .feet:
            return inputValue * 0.3048
        case .mile:
            return inputValue * 1609.344
        }
    }
    
    var outputValue: Double {
        switch outputUnit {
        case .meter:
            return inputInMeters
        case .kilometer:
            return inputInMeters / 1000
        case .feet:
            return inputInMeters / 0.3048
        case .mile:
            return inputInMeters / 1609.344
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
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Input")
                }
                
                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
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
