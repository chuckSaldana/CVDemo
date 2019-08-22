//
//  MainViewControllerViewModel.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainViewControllerViewModel:NSObject, UITableViewDataSource {
    weak var curriculum: Curriculum?
    var cvItems: [String: NSManagedObject] = [:]
    var items = [SectionInfo]()
    
    // Create the table sections and it's cell's information
    convenience init(curriculum: Curriculum?) {
        self.init()
        guard let safeCurriculum = curriculum else {
            return
        }
        
        // Profile
        let profile = ProfileCellInfo(photoPath: safeCurriculum.photo_path,
                                      name: safeCurriculum.name,
                                      label: safeCurriculum.label,
                                      summary: safeCurriculum.summary)
        items.append(profile)
        
        // Contact
        if let contact = curriculum?.contact {
            var location: String = ""
            // Build location string with available data
            if let city = contact.location?.city {
                if let state = contact.location?.state {
                    location = city + ", " + state
                } else {
                    location = city
                }
            } else {
                if let state = contact.location?.state {
                    location = state
                }
            }
            
            let contactItem = ContactCellInfo(email: contact.email,
                                              phone: contact.phone,
                                              website: contact.website,
                                              location: location)
            items.append(contactItem)
        }
        
        // Work experience
        if let roles = curriculum?.roles {
            var roleItems: [RoleCellInfo] = []
            for role in Array(roles) {
                guard let role = role as? Role else { continue }
                // Build date range string with available data
                var dateRange: String = ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-dd-MM"
                if let dateStart = role.date_start {
                    if let dateEnd = role.date_end {
                        dateRange = "From: " + dateFormatter.string(from: dateStart) + " to " + dateFormatter.string(from: dateEnd)
                    } else {
                        dateRange = "From: " + dateFormatter.string(from: dateStart) + " to Current"
                    }
                }
                
                let roleInfo = RoleCellInfo(company: role.company, dateRange: dateRange)
                roleItems.append(roleInfo)
            }
            
            let roleSection = RoleSection(roles: roleItems)
            items.append(roleSection)
        }
        
        // Education
        if let educationExperiences = curriculum?.educations {
            var educationItems: [EducationCellInfo] = []
            for education in Array(educationExperiences) {
                guard let education = education as? Education else { continue }
                // Build date range string with available data
                var dateRange: String = ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-dd-MM"
                if let dateStart = education.date_start {
                    if let dateEnd = education.date_end {
                        dateRange = "From: " + dateFormatter.string(from: dateStart) + " to " + dateFormatter.string(from: dateEnd)
                    } else {
                        dateRange = "From: " + dateFormatter.string(from: dateStart) + " to Current"
                    }
                }
                
                let educationInfo = EducationCellInfo(institution: education.institution,
                                                      degree: education.degree_earned,
                                                      dateRange: dateRange)
                educationItems.append(educationInfo)
            }
            
            let educationSection = EducationSection(educationExperiences: educationItems)
            items.append(educationSection)
        }
        
        // Skills
        if let skills = curriculum?.skills {
            var skillItems: [SkillCellInfo] = []
            for skill in Array(skills) {
                guard let skill = skill as? Skill else { continue }
                
                let skillInfo = SkillCellInfo(name: skill.name)
                skillItems.append(skillInfo)
            }
            
            let skillSection = SkillSection(skills: skillItems)
            items.append(skillSection)
        }
        
        // References
        if let references = curriculum?.references {
            var referenceItems: [ReferenceCellInfo] = []
            for reference in Array(references) {
                guard let reference = reference as? Reference else { continue }
                
                let referenceInfo = ReferenceCellInfo(name: reference.name,
                                                      email: reference.email,
                                                      phone: reference.phone)
                referenceItems.append(referenceInfo)
            }
            
            let referenceSection = ReferenceSection(references: referenceItems)
            items.append(referenceSection)
        }
        
        // Interests
        if let interests = curriculum?.interests {
            var interestItems: [InterestCellInfo] = []
            for interest in Array(interests) {
                guard let interest = interest as? Interest else { continue }
                
                let interestInfo = InterestCellInfo(name: interest.summary)
                interestItems.append(interestInfo)
            }
            
            let interestSection = InterestsSection(interests: interestItems)
            items.append(interestSection)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = items[section]
        return section.items.count > 0 ? section.items.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = items[indexPath.section]
        var cellType: CVCellType = .none
        if let sectionCell = section as? CellInfo {
            cellType = sectionCell.type
        } else if section.items.count > 0 {
            cellType = section.items[0].type
        }
        
        switch cellType {
        case .profile:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.cellIdentifier, for: indexPath) as? ProfileCell,
                let profile = section as? CellInfo {
                cell.info = profile
                return cell
            }
        case .contact:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.cellIdentifier, for: indexPath) as? ContactCell,
                let contact = section as? CellInfo {
                cell.info = contact
                return cell
            }
        case .education:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EducationCell.cellIdentifier, for: indexPath) as? EducationCell {
                cell.info = section.items[indexPath.row]
                return cell
            }
        case .interest:
            if let cell = tableView.dequeueReusableCell(withIdentifier: InterestCell.cellIdentifier, for: indexPath) as? InterestCell {
                cell.info = section.items[indexPath.row]
                return cell
            }
        case .reference:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReferenceCell.cellIdentifier, for: indexPath) as? ReferenceCell {
                cell.info = section.items[indexPath.row]
                return cell
            }
        case .role:
            if let cell = tableView.dequeueReusableCell(withIdentifier: WorkCell.cellIdentifier, for: indexPath) as? WorkCell {
                cell.info = section.items[indexPath.row]
                return cell
            }
        case .skill:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SkillCell.cellIdentifier, for: indexPath) as? SkillCell {
                cell.info = section.items[indexPath.row]
                return cell
            }
        case .none:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch items[indexPath.section].type {
//            // do appropriate action for each type      }
//        }
    }
}
