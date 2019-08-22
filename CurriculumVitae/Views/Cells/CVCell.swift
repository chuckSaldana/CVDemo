//
//  CVCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 21/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

// Make uniform cells by having a common info property
protocol CVCell {
    var info: CellInfo? { get set }
}
