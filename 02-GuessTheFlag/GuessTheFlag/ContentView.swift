//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Benjamin on 19/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    @State private var numQuestions = 0
    @State private var showingFinal = false

    @State private var animationAmounts = [0.0, 0.0, 0.0]
    @State private var opacities = [1.0, 1.0, 1.0]
    @State private var scales = [1.0, 1.0, 1.0]

    var body: some View {
        ZStack {
            // dont use .background since it only does the VStack
            // this ZStack solution does the whole screen
//            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea() // go outside of ZStack
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                
                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                animateIfCorrect(number)
                                updateOpacities(number)
                                updateScale(number)
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(countries[number].lowercased())
                        }
                        .rotation3DEffect(.degrees(animationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                        .opacity(opacities[number])
                        .scaleEffect(scales[number])
                    }
                }
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            .alert("You're done!", isPresented: $showingFinal) {
                Button("Continue", action: reset)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[correctAnswer])"
            score -= 1
            if score < 0 { score = 0 }
        }

        showingScore = true
    }
    
    func askQuestion() {
        numQuestions += 1
        
        if numQuestions == 4 {
            showingFinal = true
            return
        }

        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        for number in 0..<3 {
            animationAmounts[number] = 0.0
            opacities[number] = 1.0
            scales[number] = 1.0
        }
    }
    
    func reset() {
        askQuestion()
        numQuestions = 0
        score = 0
    }

    // MARK: Project 6 challenges

    func isCorrect(_ number: Int) -> Bool {
        return number == correctAnswer
    }

    func animateIfCorrect(_ number: Int) {
        if isCorrect(number) {
            animationAmounts[number] += 360
        }
    }

    func updateOpacities(_ number: Int) {
        for number in 0..<3 {
            opacities[number] = isCorrect(number) ? 1.0 : 0.25
        }
    }

    func updateScale(_ number: Int) {
        for number in 0..<3 {
            scales[number] = isCorrect(number) ? 1.0 : 0.25
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Exercise from day 23, https://www.hackingwithswift.com/books/ios-swiftui/views-and-modifiers-wrap-up

struct FlagImage: View {
    internal init(_ imageName: String) {
        self.imageName = imageName
    }
    
    let imageName: String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)

    }
}
