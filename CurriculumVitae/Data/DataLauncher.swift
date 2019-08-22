//
//  DataLauncher.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit
// This struct is thought as a place that contains references to
// global objects that may be needed by other objects of our app
struct DataLauncher: Launcher {
    static let shared = DataLauncher()
    
    var dataFetcher: CVFetcher = CVFetcher()
    var parser: CVParser = CVParser()
    var coreDataHandler: CoreDataHandler?
    internal var curriculum: Curriculum?
    
    init() {
        coreDataHandler = CoreDataHandler()
    }
    
    // Download JSON, parse it and save it to DB
    func launchAppData() {
        do {
            try dataFetcher.fetchCV(endpoint: .basicCV) { cvDictionary in
                DispatchQueue.main.async {
                    do {
                        try self.parser.getCVWith(dictionary: cvDictionary)
                        try self.coreDataHandler?.saveData()
                        NotificationCenter.default.post(name: DataLauncher.didDownloadDataNotification, object: nil)
                    } catch let error {
                        self.displayErrorMessage("Error while loading application's data.")
                        print("Error: \(error)")
                    }
                }
            }
        } catch {
            displayErrorMessage("Error while loading application's data.")
            print("Error: \(error)")
        }
    }
    
    func displayErrorMessage(_ message: String) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate,
            let rootViewController = delegate.window?.rootViewController {
            rootViewController.displayErrorMessage(message)
        }
    }
}

extension DataLauncher {
    static let didDownloadDataNotification = NSNotification.Name(rawValue: "didDownloadData")
}
