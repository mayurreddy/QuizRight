//
//  StageTen.swift
//  QuizRight
//
//  Created by Mayur on 8/20/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct StageTen: Stageable {
    let id = 10
    let name = "Perfect Squares - II"
    let description = "Select all perfect squares"
    let totalCount = 25
    let correctCount = 5
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (1...33).shuffled()
        return Array(shuffled.prefix(through: 4).map { $0 * $0 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (1...33).shuffled()
        return Array(shuffled.prefix(through: 19).map {
            return $0 * $0 + 1
        })
    }()
}
