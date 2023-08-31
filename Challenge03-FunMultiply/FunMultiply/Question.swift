//
//  Question.swift
//  FunMultiply
//
//  Created by Benjamin van den Hout on 31/08/2023.
//

import Foundation

struct Question: Identifiable {
    var id = UUID()
    var table: Int
    var value: Int
    var answers: [Int]

    static func generate(table: Int, numQuestions: Int) -> [Question] {
        guard numQuestions > 0 else {
            fatalError("Cannot generate empty question list")
        }

        var result = [Question]()
        for _ in 0..<numQuestions {

            var answers = [Int]()
            for i in 1...10 {
                answers.append(i*table)
            }
            answers.shuffle()

            let question = Question(table: table,
                                    value: Int.random(in: 1...10),
                                    answers: answers)
            result.append(question)
        }
        return result
    }

    func checkResult(_ answer: Int) -> Bool {
        return desiredAnswer == answer
    }

    var desiredAnswer: Int {
        return table * value
    }
}
