//
//  GameView.swift
//  FunMultiply
//
//  Created by Benjamin van den Hout on 31/08/2023.
//

import SwiftUI

struct GameView: View {
    /// Dismiss action
    @Environment(\.dismiss) private var dismiss

    @State var questions = [Question]()
    @State var score = 0
    @State var index = 0
    @State private var scoreTitle = ""
    @State private var scoreExplanation = ""
    @State private var showingScore = false
    @State var answer: String = ""

    func checkAnswer(_ question: Question) {
        let result = question.checkResult(Int(answer) ?? -1234)
        if result {
            score += 1
            scoreTitle = "Yes, dat is goed!"
        } else {
            scoreTitle = "Helaas!"
        }

        scoreExplanation = "\(question.table) keer \(question.value) = \(question.desiredAnswer)"
        showingScore = true
    }

    func askQuestion() {
        index += 1
        answer = ""
    }

    var body: some View {
        VStack {
            if let question = getQuestion(index) {
                VStack {
                    Text("Score: \(score)")
                    Spacer()
                    Text("Hoeveel is \(question.value) keer \(question.table)?")

                    Spacer()

                    ForEach(1..<10) { value in
                        Button {
                            checkAnswer(question)
                        } label: {
                            Text("\(value)")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .id(index)
            }
            else {
                EmptyView()
            }
        }
        .padding()
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Volgende") {
                askQuestion()
            }
        } message: {
            VStack {
                Text("\(scoreExplanation)\n\nJe score is nu: \(score)")
            }
        }

//        NavigationView {
//            VStack {
//                if let question = getQuestion(index) {
//                    QuestionView(question: questions[index]) { result in
//
//
//                        scoreExplanation = "\(question.table) keer \(question.value) = \(question.desiredAnswer)"
//                        index += 1
//                        showingScore = true
//                    }
//                    .id(question.id) // Make sure the view gets refreshed
//                } else {
//                    DoneView(score: score) {
//                        dismiss()
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "xmark")
//                    }
//                }
//            }
//        }
//
    }

    func getQuestion(_ index: Int) -> Question? {
        guard index < questions.count else { return nil }
        return questions[index]
    }

    private struct QuestionView: View {
        @State var question: Question
        @State var answer: String = ""

        var onCheck: (Bool) -> Void

        var body: some View {
            Form {
                Section {
                    Text("Hoeveel is \(question.value) keer \(question.table)?")
                }

                Section {
                    TextField("Antwoord", text: $answer)
                        .keyboardType(.numberPad)
                }

            }

            Button("Controleer") {
                let result = question.checkResult(Int(answer) ?? -1)
                onCheck(result)
            }
            .disabled(answer.isEmpty)
            .buttonStyle(.borderedProminent)
        }
    }

    private struct DoneView: View {
        @State var score: Int
        var onComplete: () -> Void

        var body: some View {
            Text("Klaar!")

            Button("Doei") {
                onComplete()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
