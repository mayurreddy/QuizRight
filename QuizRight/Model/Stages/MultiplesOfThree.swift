//
//  MultiplesOfThree.swift
//  QuizRight
//
//  Created by Mayur on 8/19/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct MultiplesOfThree: Stageable {
    let id = 5
    let name = "Multiples of 3"
    let description = "Select all multiples of 3"
    let totalCount = 9
    let correctCount = 3
    
    lazy var correctAnswers: [Int] = {
        let firstThirtyThree = (1...33).shuffled()
        return Array(firstThirtyThree.prefix(through: 2).map { $0 * 3 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let firstThirtyThree = (1...33).shuffled()
        return Array(firstThirtyThree.prefix(through: 5).map { $0 * 3 + ($0 % 2 + 1) })
    }()
}
