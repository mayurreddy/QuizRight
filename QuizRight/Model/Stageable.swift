//
//  Stageable.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation

protocol Stageable {
    var id: Int { get }
    var name: String { get }
    var description: String { get }
    var totalCount: Int { get }
    var correctCount: Int { get }
    var correctAnswers: [Int] { mutating get }
    var wrongAnswers: [Int] { mutating get }
}
