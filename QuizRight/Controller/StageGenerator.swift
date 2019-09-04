//
//  StageGenerator.swift
//  QuizRight
//
//  Created by Mayur on 8/19/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct StageGenerator {
    static let allStages: [Stageable] = [
        StageOne(),
        StageTwo(),
        StageThree(),
        StageFour(),
        StageFive(),
        StageSix(),
        StageSeven(),
        StageEight(),
        StageNine(),
        StageTen(),
        MultiplesOfSeven(),
        MultiplesOfSevenPartTwo(),
        MultiplesOfEleven(),
        MultiplesOfElevenPartTwo(),
        Addition(),
        AdditionPartTwo()
    ]
    
    static func getStage(index: Int) -> Stageable {
        return allStages[index]
    }
    
    static func hasNextStage(index: Int) -> Bool {
        return index < allStages.count - 1
    }
    
    static func getNextStage(index: Int) -> Stageable? {
        guard hasNextStage(index: index) else {
            return nil
        }
        return allStages[index + 1]
    }
    
    static func getStageCount() -> Int {
        return allStages.count
    }
}
