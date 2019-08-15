//
//  StageTwo.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct StageTwo: Stageable {
    let id = 2
    let name = "Odds"
    let description = "Select all odd numbers"
    let totalCount = 9
    let correctCount = 3
    
    lazy var correctAnswers: [Int] = {
        let firstHundred = (0...99).shuffled()
        return Array(firstHundred.prefix(through: 2).map { $0 * 2 + 1})
    }()
    
    lazy var wrongAnswers: [Int] = {
        let firstHundred = (0...99).shuffled()
        return Array(firstHundred.prefix(through: 5).map { $0 * 2 })
    }()
}
