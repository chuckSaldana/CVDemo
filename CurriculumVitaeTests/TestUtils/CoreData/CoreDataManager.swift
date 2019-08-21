//
//  CoreDataManager.swift
//  CurriculumVitaeTests
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private var storeType: String = "NSInMemoryStoreType"
    
    public var managedObjectModel: NSManagedObjectModel = {
        var modelPath = Bundle.main.path(
            forResource: "CurriculumVitae",
            ofType: "momd")
        var modelURL = NSURL.fileURL(withPath: modelPath!)
        var model = NSManagedObjectModel(contentsOf: modelURL)!
        return model
    }()
    
    lazy var persistentContainer: NSPersistentContainer! = {
        let persistentContainer = NSPersistentContainer(name: "TestingWithCoreData_Example", managedObjectModel: self.managedObjectModel)
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = storeType
        
        return persistentContainer
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
  
    static let shared = CoreDataManager()
    
    func setup(storeType: String = NSSQLiteStoreType, completion: (() -> Void)?) {
        self.storeType = storeType
        
        loadPersistentStore {
            completion?()
        }
    }
    
    private func loadPersistentStore(completion: @escaping () -> Void) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
            
            completion()
        }
    }
}
