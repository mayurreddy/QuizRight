//
//  MultiplesOfSevenPartTwo.swift
//  QuizRight
//
//  Created by Mayur on 8/29/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct MultiplesOfSevenPartTwo: Stageable {
    let id = 12
    let name = "Multiples of 7 - II"
    let description = "Select all multiples of 7"
    let totalCount = 25
    let correctCount = 5
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (14...140).shuffled()
        return Array(shuffled.prefix(through: 4).map { $0 * 7 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (14...140).shuffled()
        return Array(shuffled.prefix(through: 19).map {
            let rand = Int.random(in: 1...6)
            return $0 * 7 + rand
        })
    }()
}
