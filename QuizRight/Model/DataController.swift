//
//  DataController.swift
//  QuizRight
//
//  Created by Mayur on 8/15/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    lazy var container: NSPersistentContainer = {
        return NSPersistentContainer(name: "QuizRight")
    }()
    
    lazy var context: NSManagedObjectContext = {
        self.container.viewContext
    }()
    
    func setup() {
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}
