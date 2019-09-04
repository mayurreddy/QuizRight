//
//  StageVM.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class StageVM {
    /// private properties
    let id: Int
    private let name: String
    private let description: String
    private let details: String
    private let totalCount: Int
    private let correctCount: Int
    private let correctAnswers: [Int]
    private let allOptions: [Int]
    private let squareRoot: Int
    private var alreadyAnswered = Set<Int>()
    private var timer: Disposable?
    
    /// public properties
    let elapsedTime = BehaviorRelay<Double>(value: 0.0)
    
    init(stage: Stageable) {
        var stage = stage
        self.id = stage.id
        self.name = stage.name
        self.description = stage.description
        self.details = stage.details
        self.totalCount = stage.totalCount
        self.correctCount = stage.correctCount
        self.correctAnswers = stage.correctAnswers
        let all = stage.correctAnswers + stage.wrongAnswers
        var tempAll = [Int]()
        let shuffled = (0..<all.count).shuffled()
        for index in shuffled {
            tempAll.append(all[index])
        }
        self.allOptions = tempAll
        self.squareRoot = Int(sqrt(Double(totalCount)))
    }
    
    func getStageName() -> String {
        return name
    }
    
    func getStageDescription() -> String {
        return description
    }
    
    func getStageDetails() -> String {
        return details
    }
    
    func getPersonalBest() -> Double? {
        return stageStore.getPersonalBestForStage(id: id)
    }
    
    func getTotalCount() -> Int {
        return totalCount
    }
    
    func getOption(at indexPath: IndexPath) -> Int? {
        let row = indexPath.row
        let section = indexPath.section
        let index = section * squareRoot + row
        guard index < allOptions.count else {
            return nil
        }
        return allOptions[index]
    }
    
    func getBackgroundColor(for indexPath: IndexPath) -> UIColor {
        guard let option = getOption(at: indexPath) else { return .white }
        return alreadyAnswered.contains(option) ? .primaryGreen : .white
    }
    
    func getDimension() -> Int {
        return squareRoot
    }
    
    func getAllOptions() -> [Int] {
        return allOptions
    }
    
    func isCorrectAnswer(answer: Int) -> Bool {
        let isCorrect = correctAnswers.contains(answer)
        if isCorrect {
            alreadyAnswered.insert(answer)
        }
        return isCorrect
    }
    
    func isStageComplete() -> Bool {
        return alreadyAnswered.count == correctCount
    }
    
    func hasNextStage() -> Bool {
        return StageGenerator.hasNextStage(index: id-1)
    }
    
    func startCounter() {
        timer = Observable<Int>.timer(
                .seconds(0),
                period: .milliseconds(100),
                scheduler: MainScheduler.instance
            )
            .scan(0.0) { previous, _ in
                return previous + 0.1
            }
            .map { value -> Double in
                return Double(round(10 * value) / 10)
            }
            .subscribe({ [weak self] event in
                guard let el = event.element else { return }
                self?.elapsedTime.accept(el)
            })
    }
    
    func stopCounter() {
        timer?.dispose()
    }
}
