//
//  Multiplication.swift
//  QuizRight
//
//  Created by Mayur on 9/6/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct Multiplication: Stageable {
    let id = 19
    let name = "Multiplication"
    let description = "Choose the correct products"
    let totalCount = 9
    let correctCount = 3
    
    lazy var details: String = {
        let inputStrings = multipliers.reduce("") {
            prevString, array -> String in
            return "\(prevString)\(array[0]) * \(array[1])\n"
        }
        return "\(self.description) of:\n\(inputStrings)"
    }()
    
    lazy var correctAnswers: [Int] = {
        return multipliers.map { $0[0] * $0[1] }
    }()
    
    lazy var wrongAnswers: [Int] = {
        var result = [Int]()
        var wrongCount = totalCount - correctCount
        var found = 0
        while found < wrongCount {
            let rand = Int.random(in: 4...81)
            guard !correctAnswers.contains(rand) else {
                continue
            }
            
            found += 1
            result.append(rand)
        }
        return result
    }()
    
    private lazy var multipliers: [[Int]] = {
        var multipliers = [[Int]]()
        var products = [Int]()
        var found = 0
        while found < correctCount {
            let first = Int.random(in: 2...9)
            let second = Int.random(in: 2...9)
            let product = first * second
            
            guard !products.contains(product) else {
                continue
            }
            
            products.append(product)
            multipliers.append([first, second])
            found += 1
        }
        return multipliers
    }()
}
