//
//  StageMO+CoreDataProperties.swift
//  QuizRight
//
//  Created by Mayur on 8/17/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//
//

import Foundation
import CoreData

extension StageMO {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<StageMO> {
        return NSFetchRequest<StageMO>(entityName: "Stage")
    }

    @NSManaged public var stageID: Int64
    @NSManaged public var attempts: Int64
    @NSManaged public var successes: Int64
    @NSManaged public var isCompleted: Bool
    @NSManaged public var isAttempted: Bool
    @NSManaged public var bestTime: Double
    @NSManaged public var allSuccessfulTimes: [Double]

}
