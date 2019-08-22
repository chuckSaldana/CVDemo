//
//  CVParser.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum ParsingError: Error {
    case contextNotFound
    case managedTypeNotFound
    case jsonObjectNotFound
    case dateWrongFormat
    case jsonFileNotFound
}

typealias DictionaryLocator = (object: NSManagedObject, dictionary: [String: Any])
typealias ArrayLocator = (object: NSManagedObject, array: [[String: Any]])

struct CVParser {
    // Find each object in the json and iterate throughout collections to pupulate the curriculum object
    @discardableResult
    func getCVWith(dictionary: [String: Any]) throws -> Curriculum {
        let coreDataHandler = CoreDataHandler()
        guard let context = coreDataHandler.context else {
            throw ParsingError.contextNotFound
        }
        guard let curriculumEntity = NSEntityDescription.entity(forEntityName: "Curriculum", in: context) else {
            throw ParsingError.managedTypeNotFound
        }
        
        let newCurriculum = NSManagedObject(entity: curriculumEntity, insertInto: context)
        newCurriculum.setValue(dictionary["label"], forKey: "label")
        newCurriculum.setValue(dictionary["name"], forKey: "name")
        newCurriculum.setValue(dictionary["summary"], forKey: "summary")
        newCurriculum.setValue(dictionary["photo_path"], forKey: "photo_path")
        
        //Contact
        let contactLocator: DictionaryLocator = try managedObjectAndDictionaryWith(entityName: "Contact",
                                                                                   jsonName: "contact",
                                                                                   enclosingDictionary: dictionary,
                                                                                   context: context)
        
        contactLocator.object.setValue(contactLocator.dictionary["website"], forKey: "website")
        contactLocator.object.setValue(contactLocator.dictionary["email"], forKey: "email")
        contactLocator.object.setValue(contactLocator.dictionary["phone"], forKey: "phone")
        
        let locationLocator: DictionaryLocator = try managedObjectAndDictionaryWith(entityName: "Location",
                                                                                    jsonName: "location",
                                                                                    enclosingDictionary: contactLocator.dictionary,
                                                                                    context: context)
        
        locationLocator.object.setValue(locationLocator.dictionary["state"], forKey: "state")
        locationLocator.object.setValue(locationLocator.dictionary["city"], forKey: "city")
        contactLocator.object.setValue(locationLocator.object, forKey: "location")
        
        newCurriculum.setValue(contactLocator.object, forKey: "contact")
        
        //Education
        let educationLocator: ArrayLocator = try managedObjectAndDictionaryWith(entityName: "Education",
                                                                                jsonName: "education",
                                                                                enclosingDictionary: dictionary,
                                                                                context: context)
        var educations: Set<NSManagedObject> = Set()
        for education in educationLocator.array {
            guard let educationEntity = NSEntityDescription.entity(forEntityName: "Education", in: context) else {
                throw ParsingError.managedTypeNotFound
            }
            
            let newEducation = NSManagedObject(entity: educationEntity, insertInto: context)
            newEducation.setValue(education["summary"], forKey: "summary")
            newEducation.setValue(education["degree_earned"], forKey: "degree_earned")
            newEducation.setValue(education["institution"], forKey: "institution")
            newEducation.setValue(try dateWith(string: education["date_start"] as Any), forKey: "date_start")
            newEducation.setValue(try dateWith(string: education["date_end"] as Any), forKey: "date_end")
            
            educations.insert(newEducation)
        }
        
        newCurriculum.setValue(educations, forKey: "educations")
        
        //References
        let referencesLocator: ArrayLocator = try managedObjectAndDictionaryWith(entityName: "Reference",
                                                                                jsonName: "references",
                                                                                enclosingDictionary: dictionary,
                                                                                context: context)
        var references: Set<NSManagedObject> = Set()
        for education in referencesLocator.array {
            guard let referenceEntity = NSEntityDescription.entity(forEntityName: "Reference", in: context) else {
                throw ParsingError.managedTypeNotFound
            }
            
            let newReference = NSManagedObject(entity: referenceEntity, insertInto: context)
            newReference.setValue(education["name"], forKey: "name")
            newReference.setValue(education["email"], forKey: "email")
            newReference.setValue(education["phone"], forKey: "phone")
            
            references.insert(newReference)
        }
        
        newCurriculum.setValue(references, forKey: "references")
        
        // Skills
        let skillsLocator: ArrayLocator = try managedObjectAndDictionaryWith(entityName: "Skill",
                                                                             jsonName: "skills",
                                                                             enclosingDictionary: dictionary,
                                                                             context: context)
        var skills: Set<NSManagedObject> = Set()
        for education in skillsLocator.array {
            guard let skillEntity = NSEntityDescription.entity(forEntityName: "Skill", in: context) else {
                throw ParsingError.managedTypeNotFound
            }
            
            let newSkill = NSManagedObject(entity: skillEntity, insertInto: context)
            newSkill.setValue(education["name"], forKey: "name")
            
            skills.insert(newSkill)
        }
        
        newCurriculum.setValue(skills, forKey: "skills")
        
        // Interests
        let interestsLocator: ArrayLocator = try managedObjectAndDictionaryWith(entityName: "Interest",
                                                                             jsonName: "interests",
                                                                             enclosingDictionary: dictionary,
                                                                             context: context)
        var interests: Set<NSManagedObject> = Set()
        for interest in interestsLocator.array {
            guard let skillEntity = NSEntityDescription.entity(forEntityName: "Interest", in: context) else {
                throw ParsingError.managedTypeNotFound
            }
            
            let newInterest = NSManagedObject(entity: skillEntity, insertInto: context)
            newInterest.setValue(interest["name"], forKey: "summary")
            
            interests.insert(newInterest)
        }
        
        newCurriculum.setValue(interests, forKey: "interests")
        
        // Work
        let workLocator: ArrayLocator = try managedObjectAndDictionaryWith(entityName: "Role",
                                                                             jsonName: "work",
                                                                             enclosingDictionary: dictionary,
                                                                             context: context)
        var roles: Set<NSManagedObject> = Set()
        for role in workLocator.array {
            guard let workEntity = NSEntityDescription.entity(forEntityName: "Role", in: context) else {
                throw ParsingError.managedTypeNotFound
            }
            
            let newRole = NSManagedObject(entity: workEntity, insertInto: context)
            newRole.setValue(role["summary"], forKey: "summary")
            newRole.setValue(role["company"], forKey: "company")
            newRole.setValue(role["position"], forKey: "position")
            newRole.setValue(try dateWith(string: role["date_start"] as Any), forKey: "date_start")
            newRole.setValue(try dateWith(string: role["date_end"] as Any), forKey: "date_end")
            
            let responsabilitiesLocator: ArrayLocator = try managedObjectAndDictionaryWith(entityName: "Responsability",
                                                                               jsonName: "responsabilities",
                                                                               enclosingDictionary: role,
                                                                               context: context)
            var responsabilities: Set<NSManagedObject> = Set()
            for responsability in responsabilitiesLocator.array {
                guard let skillEntity = NSEntityDescription.entity(forEntityName: "Responsability", in: context) else {
                    throw ParsingError.managedTypeNotFound
                }
                
                let newResponsability = NSManagedObject(entity: skillEntity, insertInto: context)
                newResponsability.setValue(responsability["summary"], forKey: "summary")
                
                responsabilities.insert(newResponsability)
            }
            
            newRole.setValue(responsabilities, forKey: "responsabilities")
            roles.insert(newRole)
        }
        
        newCurriculum.setValue(roles, forKey: "roles")
        
        guard let curriculum = newCurriculum as? Curriculum else {
            throw ParsingError.managedTypeNotFound
        }
        
        return curriculum
    }
    
    // Create a NSManagedObject instance and find the corresponding json object
    func managedObjectAndDictionaryWith<T>(entityName: String, jsonName: String, enclosingDictionary: [String: Any], context: NSManagedObjectContext) throws -> (NSManagedObject, T) where T: Collection {
        
        guard let locationEntity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            throw ParsingError.managedTypeNotFound
        }
        let newLocation = NSManagedObject(entity: locationEntity, insertInto: context)
        guard let locationDictionary = enclosingDictionary[jsonName] as? T else {
            throw ParsingError.jsonObjectNotFound
        }
        
        return (newLocation, locationDictionary)
    }
    
    // Convert date
    func dateWith(string: Any) throws -> Date? {
        guard let dateStr = string as? String else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        
        guard let date = dateFormatter.date(from: dateStr) else {
            throw ParsingError.dateWrongFormat
        }
        
        return date
    }
}
