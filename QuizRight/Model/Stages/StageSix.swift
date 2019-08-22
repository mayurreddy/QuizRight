//
//  StageSix.swift
//  QuizRight
//
//  Created by Mayur on 8/19/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct StageSix: Stageable {
    let id = 6
    let name = "Multiples of 3 - II"
    let description = "Select all multiples of 3"
    let totalCount = 25
    let correctCount = 5
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (34...333).shuffled()
        return Array(shuffled.prefix(through: 4).map { $0 * 3 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (34...332).shuffled()
        return Array(shuffled.prefix(through: 19).map { $0 * 3 + ($0 % 2 + 1) })
    }()
}
