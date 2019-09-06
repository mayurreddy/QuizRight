//
//  MultiplesOfFourPartTwo.swift
//  QuizRight
//
//  Created by Mayur on 8/20/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct MultiplesOfFourPartTwo: Stageable {
    let id = 8
    let name = "Multiples of 4 - II"
    let description = "Select all multiples of 4"
    let totalCount = 25
    let correctCount = 5
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (25...249).shuffled()
        return Array(shuffled.prefix(through: 4).map { $0 * 4 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (25...248).shuffled()
        return Array(shuffled.prefix(through: 19).map { $0 * 4 + 2 })
    }()
}
