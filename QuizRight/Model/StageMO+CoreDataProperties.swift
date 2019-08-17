//
//  StageMO+CoreDataProperties.swift
//  QuizRight
//
//  Created by Mayur on 8/15/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//
//

import Foundation
import CoreData


extension StageMO {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<StageMO> {
        return NSFetchRequest<StageMO>(entityName: "Stage")
    }

    @NSManaged public var name: String
    @NSManaged public var stageID: Int64

}
