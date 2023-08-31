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
    @State var index = 0
    @State var score = 0

    @State private var scoreTitle = ""
    @State private var scoreExplanation = ""
    @State private var showingScore = false
    @State private var showingFinal = false

    @State private var animationAmounts = [Double](repeating: 0.0, count: 10)
    @State private var opacities = [Double](repeating: 1.0, count: 10)

    var body: some View {
        let question = questions[index]
        VStack {
            Text("Score: \(score)")

            Spacer()

            Text("Hoeveel is \(question.value) keer \(question.table)?")

            Spacer()

            ForEach(0..<10) { number in
                let answer = question.answers[number]

                Button {
                    withAnimation {
                        animateIfCorrect(number)
                        updateOpacities(number, correct: question.checkResult(answer))
                    }
                    checkAnswer(question, answer: question.answers[number])
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
        .alert("Dat was het!", isPresented: $showingFinal) {
            Button("Doei!") {
                dismiss()
            }
        } message: {
            Text("Je score is \(score)\nVeel succes de volgende keer!")
        }
    }

    func checkAnswer(_ question: Question, answer: Int) {
        let result = question.checkResult(answer)
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
        guard index + 1 < questions.count else {
            clearOpacities()
            showingFinal = true
            return
        }

        index += 1

        for number in 0..<10 {
            animationAmounts[number] = 0.0
            opacities[number] = 1.0
        }
    }

    func getQuestion(_ index: Int) -> Question? {
        guard index < questions.count else { return nil }
        let question = questions[index]
        return question
    }

    var currentQuestion: Question {
        questions[index]
    }

    func isCorrect(_ number: Int) -> Bool {
        currentQuestion.answers[number] == currentQuestion.desiredAnswer
    }

    func animateIfCorrect(_ number: Int) {
        if isCorrect(number) {
            animationAmounts[number] += 3600
        }
    }

    func updateOpacities(_ number: Int, correct: Bool) {
        for number in 0..<10 {
            opacities[number] = isCorrect(number) ? 1.0 : 0.25
        }
    }

    func clearOpacities() {
        for number in 0..<10 {
            opacities[number] = 0.25
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

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
