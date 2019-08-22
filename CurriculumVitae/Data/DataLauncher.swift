//
//  DataLauncher.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

struct DataLauncher: Launcher {
    static let shared = DataLauncher()
    var dataFetcher: CVFetcher = CVFetcher()
    var parser: CVParser = CVParser()
    var coreDataHandler: CoreDataHandler?
    var curriculum: Curriculum?
    
    init() {
        coreDataHandler = CoreDataHandler()
    }
    
    func launchAppData() {
        dataFetcher.fetchCV(endpoint: .basicCV) { cvDictionary in
            DispatchQueue.main.async {
                do {
                    try self.parser.getCVWith(dictionary: cvDictionary)
                    try self.coreDataHandler?.saveData()
                } catch let error {
                    print("Error: \(error)")
                }
            }
        }
    }
}
