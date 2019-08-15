//
//  StageListVM.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct StageListVM {
    private let allStages: [Stageable] = [
        StageOne(),
        StageTwo(),
        StageThree(),
        StageFour()
    ]
    
    func getStage(for index: Int) -> Stageable {
        return allStages[index]
    }
    
    func getStageCount() -> Int {
        return allStages.count
    }
}
