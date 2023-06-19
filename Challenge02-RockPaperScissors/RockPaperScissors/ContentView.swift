//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Benjamin on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    private static let moves = ["Rock", "Paper", "Scissors"]
    private static let winningMove = ["Paper", "Scissors", "Rock"]
    
    @State private var currentChoice = Int.random(in: 0..<moves.count)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var count = 0
    
    @State private var showingScore = false

    var body: some View {
        VStack {
            Spacer()
            
            Text("Score: \(score)")
                .font(.largeTitle)
                .padding()

            Text("Move: \(ContentView.moves[currentChoice])")
                .font(.title)
                .padding()

            Text("Should win: \(shouldWin ? "Yes" : "No")")
                .font(.title)
                .padding()
            
            Spacer()
            
            VStack {
                Button("🪨") {
                    self.buttonPressed("Rock")
                }
                .buttonStyle(background: Color.yellow)

                Button("📃") {
                    self.buttonPressed("Paper")

                }
                .buttonStyle(background: Color.purple)

                Button("✂") {
                    self.buttonPressed("Scissors")
                }
                .buttonStyle(background: Color.blue)

            }
            .font(.system(size: 100))
            
            Spacer()
        }
        .alert("Final score", isPresented: $showingScore) {
            Button("OK") {
                reset(gameFinished: true)
            }
        } message: {
            Text("Final score: \(score)")
        }

    }
    
    private func buttonPressed(_ value: String) {
        if shouldWin {
            if value == ContentView.winningMove[currentChoice] {
                score += 1
            }
        } else {
            if value != ContentView.winningMove[currentChoice] {
                score += 1
            }
        }

        count += 1
        
        if count == 10 {
            showingScore = true
            return
        }

        reset(gameFinished: false)
    }
    
    private func reset(gameFinished: Bool) {
        if gameFinished {
            count = 0
            score = 0
        }
        currentChoice = Int.random(in: 0..<ContentView.moves.count)
        shouldWin = Bool.random()

    }
}

struct ButtonStyle: ViewModifier {
    var background: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
    }
}

extension View {
    func buttonStyle(background: Color) -> some View {
        modifier(ButtonStyle(background: background))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
