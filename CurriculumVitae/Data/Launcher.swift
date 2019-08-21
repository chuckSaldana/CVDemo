//
//  Launcher.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

protocol Launcher {
    var dataFetcher: CVFetcher { get set }
    var parser: CVParser { get set }
    var coreDataHandler: CoreDataHandler? { get set }
    
    func launchAppData()
}
