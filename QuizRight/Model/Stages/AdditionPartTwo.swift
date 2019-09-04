//
//  AdditionPartTwo.swift
//  QuizRight
//
//  Created by Mayur on 9/4/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct AdditionPartTwo: Stageable {
    let id = 16
    let name = "Addition - II"
    let description = "Choose the correct sums"
    let totalCount = 16
    let correctCount = 4
    
    lazy var details: String = {
        let addendStrings = addends.reduce("") {
            prevString, array -> String in
            return "\(prevString)\(array[0]) + \(array[1])\n"
        }
        return "\(self.description) of:\n\(addendStrings)"
    }()
    
    lazy var correctAnswers: [Int] = {
        return addends.map { $0.reduce(0,+) }
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
            let randomWrong = Int.random(in: 200...1998)
            if !correctAnswers.contains(randomWrong) {
                result.append(randomWrong)
                wrongToGo -= 1
            }
        }
        return result
    }()
    
    private lazy var addends: [[Int]] = {
        var result = [[Int]]()
        for _ in 0..<correctCount {
            let first = Int.random(in: 100...999)
            let second = Int.random(in: 100...999)
            result.append([first, second])
        }
        return result
    }()
}
