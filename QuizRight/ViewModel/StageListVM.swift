//
//  StageListVM.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

struct StageListVM {
    
    func getStage(for index: Int) -> Stageable {
        return StageGenerator.getStage(index: index)
    }
    
    func getStageCount() -> Int {
        return StageGenerator.getStageCount()
    }
}
