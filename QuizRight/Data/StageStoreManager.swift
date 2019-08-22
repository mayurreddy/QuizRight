//
//  StageStoreManager.swift
//  QuizRight
//
//  Created by Mayur on 8/17/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation
import CoreData

class StageStoreManager: StageStorable {
    
    private var allAttemptedStages: [StageMO] = []
    
    func getAllAttemptedStages(forceUpdate: Bool = false) -> [Int] {
        guard forceUpdate || allAttemptedStages.isEmpty else {
            return allAttemptedStages.map { Int($0.stageID) }
        }
        refresh()
        return allAttemptedStages.map { Int($0.stageID) }
    }
    
    func getAllCompletedStages(forceUpdate: Bool) -> [Int] {
        guard forceUpdate || allAttemptedStages.isEmpty else {
            return allAttemptedStages
                .filter { $0.isCompleted }
                .map { Int($0.stageID) }
        }
        
        refresh()
        return allAttemptedStages
            .filter { $0.isCompleted }
            .map { Int($0.stageID) }
    }
    
    func getLastStageCompleted() -> Int? {
        return nil
    }
    
    func isStageAttempted(id: Int) -> Bool {
        return allAttemptedStages.contains { Int($0.stageID) == id }
    }
    
    func isStageCompleted(id: Int) -> Bool {
        guard let stage = getStageMO(id: id) else {
            return false
        }
        return stage.isCompleted
    }
    
    func getPersonalBestForStage(id: Int) -> Double? {
        guard let stage = getStageMO(id: id), stage.isCompleted else {
            return nil
        }
        return stage.bestTime
    }
    
    func getTotalAttemptsForStage(id: Int) -> Int {
        guard let stage = getStageMO(id: id) else {
            return 0
        }
        return Int(stage.attempts)
    }
    
    func getSuccessfulAttemptsForStage(id: Int) -> Int {
        guard let stage = getStageMO(id: id) else {
            return 0
        }
        return Int(stage.successes)
    }
    
    func getAverageTimeForStage(id: Int) -> Double? {
        guard let stage = getStageMO(id: id) else {
            return nil
        }
        
        let totalTime = stage.allSuccessfulTimes.reduce(0.0, +)
        return totalTime / Double(stage.successes)
    }
    
    func getAllTimesForStage(id: Int) -> [Double]? {
        guard let stage = getStageMO(id: id) else {
            return nil
        }
        return stage.allSuccessfulTimes
    }
    
    func resetStage(id: Int) {
        let request = StageMO.createFetchRequest()
        let predicate = NSPredicate(format: "stageID == '\(id)'")
        request.predicate = predicate
        
        do {
            let objects = try dataController.context.fetch(request)
            guard let stageToDelete = objects.first, objects.count == 1 else {
                print("Exactly one stage not found")
                return
            }
            dataController.context.delete(stageToDelete)
            
        } catch {
            print("Could not find object to delete")
        }
    }
    
    func resetAllStages() {
        refresh()
        allAttemptedStages.forEach {
            dataController.context.delete($0)
        }
        allAttemptedStages = []
    }
    
    func setStageElapsedTime(id: Int, time: Double) {
        if let stage = getStageMO(id: id) {
            addTimeToExistingStage(stage: stage, time: time)
        } else {
            configureNewStageTime(id: id, time: time)
        }
        
        dataController.saveContext()
        refresh()
    }
    
    func setStageFailure(id: Int) {
        if let stage = getStageMO(id: id) {
            addFailureToExistingStage(stage: stage)
        } else {
            configureNewStageFailure(id: id)
        }
        
        dataController.saveContext()
        refresh()
    }
}

extension StageStoreManager {
    func getStageMO(id: Int) -> StageMO? {
        return allAttemptedStages.first { $0.stageID == id }
    }
    
    @discardableResult
    func refresh() -> [StageMO] {
        let request = StageMO.createFetchRequest()
        guard let stages = try? dataController.context.fetch(request) else {
            print("Error fetching list of stages")
            return []
        }
        
        allAttemptedStages = stages
        return allAttemptedStages
    }
    
    private func configureNewStageTime(id: Int, time: Double) {
        let stage = StageMO(context: dataController.context)
        stage.stageID = Int64(id)
        stage.isCompleted = true
        stage.isAttempted = true
        stage.successes = 1
        stage.attempts = 1
        stage.allSuccessfulTimes = [time]
        stage.bestTime = time
    }
    
    private func addTimeToExistingStage(stage: StageMO, time: Double) {
        stage.isCompleted = true
        stage.successes += 1
        stage.attempts += 1
        let allTimes = stage.allSuccessfulTimes + [time]
        let best = allTimes.min() ?? time
        stage.allSuccessfulTimes = allTimes
        stage.bestTime = best
    }
    
    private func configureNewStageFailure(id: Int) {
        let stage = StageMO(context: dataController.context)
        stage.stageID = Int64(id)
        stage.isCompleted = false
        stage.isAttempted = true
        stage.successes = 0
        stage.attempts = 1
        stage.allSuccessfulTimes = []
        stage.bestTime = Double.infinity
    }
    
    private func addFailureToExistingStage(stage: StageMO) {
        stage.attempts += 1
    }
}
