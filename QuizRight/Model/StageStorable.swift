//
//  StageStorable.swift
//  QuizRight
//
//  Created by Mayur on 8/17/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

protocol StageStorable {
    func getStagesCompleted() -> [Int]
    func getLastStageCompleted() -> Int?
    func isStageCompleted(_: Int) -> Bool
    func getPersonalBestForStage(_: Int) -> Double?
    func getTotalAttemptsForStage(_: Int) -> Int
    func getSuccessfulAttemptsForStage(_: Int) -> Int
    func getAverageTimeForStage(_: Int) -> Double?
    func getAllTimesForStage(_: Int) -> [Double]?
    
    func resetStage(_: Int)
    func resetAllStages()
    
    func setStageTime(_: Int, _: Double)
    func setStageSuccess(_: Int)
    func setStageFailure(_: Int)
}

