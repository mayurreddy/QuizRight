//
//  Subtraction.swift
//  QuizRight
//
//  Created by Mayur on 9/4/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct Subtraction: Stageable {
    let id = 17
    let name = "Subtraction"
    let description = "Choose the correct differences"
    let totalCount = 9
    let correctCount = 3
    
    lazy var details: String = {
        let inputStrings = inputs.reduce("") {
            prevString, array -> String in
            return "\(prevString)\(array[0]) - \(array[1])\n"
        }
        return "\(self.description) of:\n\(inputStrings)"
    }()
    
    lazy var correctAnswers: [Int] = {
        return inputs.map { $0[0] - $0[1] }
    }()
    
    lazy var wrongAnswers: [Int] = {
        var result = [Int]()
        var wrongToGo = totalCount - correctCount
        for correctAnswer in correctAnswers {
            let wrongAnswer = correctAnswer + 10
            if !correctAnswers.contains(wrongAnswer) {
                result.append(wrongAnswer)
                wrongToGo -= 1
            }
        }
        
        while wrongToGo > 0 {
            let range = -88...88
            let randomWrong = Int.random(in: range)
            if !correctAnswers.contains(randomWrong) {
                result.append(randomWrong)
                wrongToGo -= 1
            }
        }
        return result
    }()
    
    private lazy var inputs: [[Int]] = {
        var result = [[Int]]()
        for _ in 0..<correctCount {
            let first = Int.random(in: 11...99)
            let second = Int.random(in: 11...99)
            result.append([first, second])
        }
        return result
    }()
}
