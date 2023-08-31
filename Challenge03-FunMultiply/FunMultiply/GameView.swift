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

    @State var questions: [Question]
    @State var questionIndex = 0
    @State var currentScore = 0

    @State private var showingResult = false
    @State private var resultTitle = ""
    @State private var resultExplanation = ""

    @State private var showingFinal = false

    @State private var animationAmounts = [Double](repeating: 0.0, count: Question.numAnswers)
    @State private var opacities = [Double](repeating: 1.0, count: Question.numAnswers)

    var body: some View {
        NavigationView {
            VStack {
                HStack() {
                    Text("Score: \(currentScore)")
                    Spacer()
                    Text("Vraag \(questionIndex+1) van \(questions.count)")
                }

                Spacer()

                Text("Hoeveel is \(currentQuestion.multiplicationValue) x \(currentQuestion.table)?")
                    .font(.largeTitle.weight(.bold))

                Spacer()

                ForEach(0 ..< Question.numAnswers, id: \.self) { number in
                    let answer = currentQuestion.answers[number]

                    Button {
                        withAnimation {
                            animateIfCorrect(number)
                            updateOpacities(number)
                        }

                        checkAnswer(number)
                    } label: {
                        Text("\(answer)")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    .rotation3DEffect(.degrees(animationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(opacities[number])
                }

                Spacer()

            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }

            }
        }
        .navigationViewStyle(.stack)
        .alert(resultTitle, isPresented: $showingResult) {
            Button("Volgende") {
                askQuestion()
            }
        } message: {
            VStack {
                Text("\n\(resultExplanation)\n\nJe score is nu: \(currentScore)")
            }
        }
        .alert("Dat was het!", isPresented: $showingFinal) {
            Button("Doei!") {
                dismiss()
            }
        } message: {
            Text("Je score is \(currentScore)\nVeel succes de volgende keer!")
        }
    }

    private var currentQuestion: Question {
        questions[questionIndex]
    }

    private func askQuestion() {
        guard questionIndex + 1 < questions.count else {
            clearOpacities()
            showingFinal = true
            return
        }

        questionIndex += 1

        for number in 0 ..< Question.numAnswers {
            animationAmounts[number] = 0.0
            opacities[number] = 1.0
        }
    }

    private func checkAnswer(_ number: Int) {
        if currentQuestion.checkResult(currentQuestion.answers[number]) {
            currentScore += 1
            resultTitle = "Yes, dat is goed!"
        } else {
            resultTitle = "Helaas!"
        }

        resultExplanation = "\(currentQuestion.table) x \(currentQuestion.multiplicationValue) = \(currentQuestion.desiredAnswer)"
        showingResult = true
    }

    private func isCorrect(_ number: Int) -> Bool {
        currentQuestion.answers[number] == currentQuestion.desiredAnswer
    }

    private func animateIfCorrect(_ number: Int) {
        if isCorrect(number) {
            animationAmounts[number] += Constant.animationDegrees
        }
    }

    private func updateOpacities(_ number: Int) {
        for number in 0 ..< Question.numAnswers {
            opacities[number] = isCorrect(number) ? Constant.opacityNormal : Constant.opacityDimmed
        }
    }

    private func clearOpacities() {
        for number in 0 ..< Question.numAnswers {
            opacities[number] = Constant.opacityDimmed
        }
    }

    private struct Constant {
        static let opacityNormal = 1.0
        static let opacityDimmed = 0.25
        static let animationDegrees = 3600.0
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(questions: Question.generateQuestions(table: 2, numQuestions: 5))
            .previewDevice(PreviewDevice(rawValue: "iPad Air 2"))
        GameView(questions: Question.generateQuestions(table: 2, numQuestions: 5))
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
