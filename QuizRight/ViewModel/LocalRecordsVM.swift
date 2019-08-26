//
//  LocalRecordsVM.swift
//  QuizRight
//
//  Created by Mayur on 8/22/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class LocalRecordsVM {
    let allRecords = BehaviorRelay<[StageRecord]>(value: [])
    
    func refresh() {
        stageStore.refresh()
        
        let records = StageGenerator.allStages
            .map { stage -> StageRecord in
                let id = stage.id
                let name = stage.name
                let record: StageRecord
                
                if let attemptedStage = stageStore.getStageMO(id: id) {
                    record = StageRecord(
                        id: id,
                        name: name,
                        didAttempt: true,
                        personalBest: stageStore.getPersonalBestForStage(id: id),
                        totalAttempts: Int(attemptedStage.attempts),
                        totalSuccesses: attemptedStage.allSuccessfulTimes.count,
                        averageSuccessTime: stageStore.getAverageTimeForStage(id: id))
                } else {
                    record = StageRecord(
                        id: id,
                        name: name,
                        didAttempt: false,
                        personalBest: nil,
                        totalAttempts: 0,
                        totalSuccesses: 0,
                        averageSuccessTime: nil)
                }
                
                return record
            }
            .sorted { first, second -> Bool in
                if let firstPB = first.personalBest, let secondPB = second.personalBest {
                    return firstPB < secondPB
                } else if first.personalBest != nil {
                    return true
                } else if second.personalBest != nil {
                    return false
                } else if first.didAttempt {
                    return true
                }
                return false
            }
        
        allRecords.accept(records)
    }
}
