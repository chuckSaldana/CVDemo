//
//  CoreDataHandler.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum CoreDataHandlerError: Error {
    case appDelegateNotFound
    case failedSaving
}

class CoreDataHandler {
    var context: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.context = appDelegate.persistentContainer.viewContext
        }
    }
    
    func getCurriculum() throws -> Curriculum? {
        let entityName = "Curriculum"
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try context?.fetch(request) as? [NSManagedObject],
                result.count > 0, let curriculum = result[0] as? Curriculum {
                return curriculum
            }
        } catch {
            print("Failed to fetch entity: \(entityName)")
        }
        
        return nil
    }
    
    func saveData() throws {
        do {
            try context?.save()
        } catch {
            throw CoreDataHandlerError.failedSaving
        }
    }
    
}

