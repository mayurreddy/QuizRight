//
//  MultiplesOfFour.swift
//  QuizRight
//
//  Created by Mayur on 8/20/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct MultiplesOfFour: Stageable {
    let id = 7
    let name = "Multiples of 4"
    let description = "Select all multiples of 4"
    let totalCount = 9
    let correctCount = 3
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (1...24).shuffled()
        return Array(shuffled.prefix(through: 2).map { $0 * 4 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (1...24).shuffled()
        return Array(shuffled.prefix(through: 5).map { $0 * 4 + 2 })
    }()
}
