//
//  PerfectSquares.swift
//  QuizRight
//
//  Created by Mayur on 8/20/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct PerfectSquares: Stageable {
    let id = 9
    let name = "Perfect Squares"
    let description = "Select all perfect squares"
    let totalCount = 9
    let correctCount = 3
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (1...10).shuffled()
        return Array(shuffled.prefix(through: 2).map { $0 * $0 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (1...10).shuffled()
        return Array(shuffled.prefix(through: 5).map {
            return $0 * $0 + 1
        })
    }()
}
