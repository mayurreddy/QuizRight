//
//  MultiplesOfSeven.swift
//  QuizRight
//
//  Created by Mayur on 8/29/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct MultiplesOfSeven: Stageable {
    let id = 11
    let name = "Multiples of 7"
    let description = "Select all multiples of 7"
    let totalCount = 9
    let correctCount = 3
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (1...13).shuffled()
        return Array(shuffled.prefix(through: 2).map { $0 * 7 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (0...12).shuffled()
        return Array(shuffled.prefix(through: 5).map {
            let rand = Int.random(in: 1...6)
            return $0 * 7 + rand
        })
    }()
}
