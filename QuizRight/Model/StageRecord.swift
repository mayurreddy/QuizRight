//
//  StageRecord.swift
//  QuizRight
//
//  Created by Mayur on 8/22/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct StageRecord {
    let id: Int
    let name: String
    let didAttempt: Bool
    let personalBest: Double?
    let totalAttempts: Int
    let totalSuccesses: Int
    
    var successRate: Double {
        return Double(totalSuccesses) / Double(totalAttempts)
    }
    
    let averageSuccessTime: Double?
}
