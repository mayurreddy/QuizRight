//
//  MultiplesOfElevenPartTwo.swift
//  QuizRight
//
//  Created by Mayur on 8/29/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct MultiplesOfElevenPartTwo: Stageable {
    let id = 14
    let name = "Multiples of 11 - II"
    let description = "Select all multiples of 11"
    let totalCount = 25
    let correctCount = 5
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (11...90).shuffled()
        return Array(shuffled.prefix(through: 4).map { $0 * 11 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (11...90).shuffled()
        return Array(shuffled.prefix(through: 19).map {
            let rand = Int.random(in: 1...10)
            return $0 * 11 + rand
        })
    }()
}
