//
//  CellInfo.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 21/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

enum CVCellType {
    case profile
    case contact
    case skill
    case role
    case education
    case interest
    case reference
}

protocol CellInfo {
    var type: CVCellType { get }
}

struct ProfileCellInfo: CellInfo {
    var type: CVCellType
    var photoPath: String?
    var name: String?
    var label: String?
    var summary: String?
}

struct ContactCellInfo: CellInfo {
    var type: CVCellType = .contact
    var email: String?
    var phone: String?
    var website: String?
    var city: String?
    var state: String?
}

struct SkillCellInfo: CellInfo {
    var type: CVCellType = .skill
    var name: String?
}

struct RoleCellInfo: CellInfo {
    var type: CVCellType = .role
    var company: String?
    var dateStart: Date?
    var dateEnd: Date?
}

struct EducationCellInfo: CellInfo {
    var type: CVCellType = .education
    var institution: String?
    var degree: String?
    var dateStart: Date?
    var dateEnd: Date?
}

struct InterestCellInfo: CellInfo {
    var type: CVCellType = .interest
    var name: String?
}

struct ReferenceCellInfo: CellInfo {
    var type: CVCellType = .reference
    var name: String?
    var email: String?
    var phone: String?
}
