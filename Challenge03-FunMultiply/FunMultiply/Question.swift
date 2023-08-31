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

    static func generate(table: Int, numQuestions: Int) -> [Question] {
        var result = [Question]()
        for _ in 0..<numQuestions {
            let question = Question(table: table, value: Int.random(in: 1...10))
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
