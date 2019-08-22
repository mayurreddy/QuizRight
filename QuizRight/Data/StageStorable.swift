//
//  StageStorable.swift
//  QuizRight
//
//  Created by Mayur on 8/17/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

protocol StageStorable {
    func getAllAttemptedStages(forceUpdate: Bool) -> [Int]
    func getAllCompletedStages(forceUpdate: Bool) -> [Int]
    func getLastStageCompleted() -> Int?
    func isStageAttempted(id: Int) -> Bool
    func isStageCompleted(id: Int) -> Bool
    func getPersonalBestForStage(id: Int) -> Double?
    func getTotalAttemptsForStage(id: Int) -> Int
    func getSuccessfulAttemptsForStage(id: Int) -> Int
    func getAverageTimeForStage(id: Int) -> Double?
    func getAllTimesForStage(id: Int) -> [Double]?
    
    func resetStage(id: Int)
    func resetAllStages()
    
    func setStageElapsedTime(id: Int, time: Double)
    func setStageFailure(id: Int)
}

