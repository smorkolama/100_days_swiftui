//
//  ContentView.swift
//  FunMultiply
//
//  Created by Benjamin van den Hout on 31/08/2023.
//

import SwiftUI

let numQuestionsList = [5, 10, 20]

struct ContentView: View {
    @State private var table = 2
    @State private var numQuestions = 5
    @State private var showGameSheet = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Stepper("De tafel van \(table.formatted())", value: $table)
                    } header: {
                        Text("Ik wil oefenen met")
                    }
                    Section {
                        Picker(selection: $numQuestions) {
                            ForEach(numQuestionsList, id: \.self) { number in
                                Text(number.formatted())
                            }
                        } label: {
                        }
                        .pickerStyle(.segmented)

                    } header: {
                        Text("Hoeveel vragen wil je?")
                    }
                }

                Button {
                    showGameSheet.toggle()
                } label: {
                    Text("Daar gaan we!")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                .padding()
            }
            .navigationTitle("Tafels oefenen")
        }
        .fullScreenCover(isPresented: $showGameSheet) {
            GameView(questions: Question.generate(table: table, numQuestions: numQuestions))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
