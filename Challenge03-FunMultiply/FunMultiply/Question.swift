//
//  Question.swift
//  FunMultiply
//
//  Created by Benjamin van den Hout on 31/08/2023.
//

import Foundation

struct Question {
    static let minMultiplication = 1
    static let maxMultiplication = 10
    static let numAnswers = 10

    /// Multiplication table
    var table: Int

    /// Multiplication value
    var multiplicationValue: Int

    /// Possible answers
    var answers: [Int]

    /// Desired answer
    var desiredAnswer: Int {
        return table * multiplicationValue
    }

    /// Check if result is correct
    /// - Parameter answer: Answer to check
    /// - Returns: True if correct, false if not
    func checkResult(_ answer: Int) -> Bool {
        return desiredAnswer == answer
    }

    // MARK: - Static

    /// Generate an array of questions
    /// - Parameters:
    ///   - table: Multiplication table to use
    ///   - numQuestions: Number of questions to generate
    /// - Returns: Array of questions
    static func generateQuestions(table: Int, numQuestions: Int) -> [Question] {
        guard numQuestions > 0 else {
            fatalError("Cannot generate empty question list")
        }

        var result = [Question]()
        for _ in 0..<numQuestions {
            result.append(Question(table: table,
                                   multiplicationValue: Int.random(in: minMultiplication...maxMultiplication),
                                   answers: generateAnswers(table: table)))
        }

        return result
    }

    /// Generate the possible answers for the specified table and randomize them
    /// - Parameter table: Multiplication table
    /// - Returns: Randomized answers
    static func generateAnswers(table: Int) -> [Int] {
        var answers = [Int]()
        for i in 1...numAnswers {
            answers.append(i*table)
        }
        answers.shuffle()

        return answers
    }
}
