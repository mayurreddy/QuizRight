//
//  OddsPartTwo.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct OddsPartTwo: Stageable {
    let id = 3
    let name = "Odds - II"
    let description = "Select all odd numbers"
    let totalCount = 36
    let correctCount = 6
    
    lazy var correctAnswers: [Int] = {
        let firstHundred = (0...99).shuffled()
        return Array(firstHundred.prefix(through: 5).map { $0 * 2 + 1})
    }()
    
    lazy var wrongAnswers: [Int] = {
        let firstHundred = (0...99).shuffled()
        return Array(firstHundred.prefix(through: 29).map { $0 * 2 })
    }()
}
