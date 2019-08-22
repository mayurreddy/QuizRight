//
//  StageRecord.swift
//  QuizRight
//
//  Created by Mayur on 8/22/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

protocol StageRecordable {
    var name: String { get }
    var didAttempt: Bool { get }
    var personalBest: Double { get }
    var totalAttempts: Int { get }
    var successRate: Double { get }
    var failureRate: Double { get }
    var averageSuccessTime: Double { get }
}

struct StageRecord {
    let name: String
    let didAttempt: Bool
    let personalBest: Double?
    let totalAttempts: Int
    let totalSuccesses: Int
    
    var successRate: Double {
        return Double(totalSuccesses) / Double(totalAttempts)
    }
    
    var failureRate: Double {
        return 100.0 - successRate
    }
    
    let averageSuccessTime: Double?
}
