//
//  MultiplesOfEleven.swift
//  QuizRight
//
//  Created by Mayur on 8/29/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct MultiplesOfEleven: Stageable {
    let id = 13
    let name = "Multiples of 11"
    let description = "Select all multiples of 11"
    let totalCount = 9
    let correctCount = 3
    
    lazy var correctAnswers: [Int] = {
        let shuffled = (11...90).shuffled()
        return Array(shuffled.prefix(through: 2).map { $0 * 11 })
    }()
    
    lazy var wrongAnswers: [Int] = {
        let shuffled = (11...90).shuffled()
        return Array(shuffled.prefix(through: 5).map {
            let rand = Int.random(in: 1...10)
            return $0 * 11 + rand
        })
    }()
}
