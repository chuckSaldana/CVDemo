//
//  CellInfo.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 21/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

enum CVCellType {
    case none
    case profile
    case contact
    case skill
    case role
    case education
    case interest
    case reference
}

// Declare a basic Cell model type
protocol CellInfo {
    var type: CVCellType { get }
}

// Declare a basic Section model type
// This type's instances may contain 0 or more Cell info items
protocol SectionInfo {
    var title: String { get }
    var items: [CellInfo] { get }
}

// In order to support selction of cells that belong to a
// populated section
extension SectionInfo {
    var isSelectable: Bool {
        return items.count > 0
    }
}

// MARK: Profile
struct ProfileCellInfo: CellInfo, SectionInfo {
    var items: [CellInfo] = []
    var title: String = "Profile"
    var type: CVCellType = .profile
    var photoPath: String?
    var name: String?
    var label: String?
    var summary: String?
    
    init(photoPath: String?, name: String?, label: String?, summary: String?) {
        self.photoPath = photoPath
        self.name = name
        self.label = label
        self.summary = summary
    }
}

// MARK: Contact
struct ContactCellInfo: CellInfo, SectionInfo {
    var items: [CellInfo] = []
    var title: String = "Contact Information"
    var type: CVCellType = .contact
    var email: String?
    var phone: String?
    var website: String?
    var location: String?
    
    init(email: String?, phone: String?, website: String?, location: String?) {
        self.email = email
        self.phone = phone
        self.website = website
        self.location = location
    }
}

// MARK: Skills
struct SkillSection: SectionInfo {
    var title: String = "Skills"
    var items: [CellInfo]
    
    init(skills: [SkillCellInfo]) {
        self.items = skills
    }
}

struct SkillCellInfo: CellInfo {
    var type: CVCellType = .skill
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
}

// MARK: Work experience
struct RoleSection: SectionInfo {
    var title: String = "Work Experience"
    var items: [CellInfo]
    
    init(roles: [RoleCellInfo]) {
        self.items = roles
    }
}

struct RoleCellInfo: CellInfo {
    var type: CVCellType = .role
    var company: String?
    var dateRange: String?
    
    init(company: String?, dateRange: String?) {
        self.company = company
        self.dateRange = dateRange
    }
}

// MARK: Education
struct EducationSection: SectionInfo {
    var title: String = "Education"
    var items: [CellInfo]
    
    init(educationExperiences: [EducationCellInfo]) {
        self.items = educationExperiences
    }
}

struct EducationCellInfo: CellInfo {
    var type: CVCellType = .education
    var institution: String?
    var degree: String?
    var dateRange: String?
    
    init(institution: String?, degree: String?, dateRange: String?) {
        self.institution = institution
        self.degree = degree
        self.dateRange = dateRange
    }
}

// MARK: Interests
struct InterestsSection: SectionInfo {
    var title: String = "Interests"
    var items: [CellInfo]
    
    init(interests: [InterestCellInfo]) {
        self.items = interests
    }
}

struct InterestCellInfo: CellInfo {
    var type: CVCellType = .interest
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
}

// MARK: References
struct ReferenceSection: SectionInfo {
    var title: String = "References"
    var items: [CellInfo]
    
    init(references: [ReferenceCellInfo]) {
        self.items = references
    }
}

struct ReferenceCellInfo: CellInfo {
    var type: CVCellType = .reference
    var name: String?
    var email: String?
    var phone: String?
    
    init(name: String?, email: String?, phone: String?) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}
