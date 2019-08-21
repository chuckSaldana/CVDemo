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
    static let shared = CoreDataHandler()
    var context: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.context = appDelegate.persistentContainer.viewContext
        }
    }
    
    func saveData() throws {
        do {
            try context?.save()
        } catch {
            throw CoreDataHandlerError.failedSaving
        }
    }
    
}

