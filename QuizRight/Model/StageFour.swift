//
//  StageFour.swift
//  QuizRight
//
//  Created by Mayur on 8/13/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct StageFour: Stageable {
    let id = 4
    let name = "Evens - II"
    let description = "Select all even numbers"
    let totalCount = 36
    let correctCount = 6
    
    lazy var correctAnswers: [Int] = {
        let firstHundred = (0...99).shuffled()
        return Array(firstHundred.prefix(through: 5).map { $0 * 2 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let firstHundred = (0...99).shuffled()
        return Array(firstHundred.prefix(through: 29).map { $0 * 2 + 1 })
    }()
}
