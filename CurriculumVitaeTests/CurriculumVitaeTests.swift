//
//  CurriculumVitaeTests.swift
//  CurriculumVitaeTests
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import XCTest
@testable import CurriculumVitae
import CoreData

class ParserTests: XCTestCase {
    var parser: CVParser!

    override func setUp() {
        parser = CVParser()
    }
    
    func testValidFeedParsingNotThrows() {
        XCTAssertNoThrow(try parser.getCVWith(dictionary: FileReader.getValidSampleDictionary()))
    }
    
    func testValidFeedParsingWithValidJSON() {
        do {
            let curriculum = try parser.getCVWith(dictionary: FileReader.getValidSampleDictionary())
            XCTAssertNotNil(curriculum)
            XCTAssertNotNil(curriculum.contact)
            XCTAssertNotNil(curriculum.educations)
            XCTAssertNotNil(curriculum.interests)
            XCTAssertNotNil(curriculum.roles)
            XCTAssertNotNil(curriculum.skills)
            XCTAssertNotNil(curriculum.summary)
            XCTAssertNotNil(curriculum.references)
            XCTAssertNotNil(curriculum.photo_path)
            XCTAssertNotNil(curriculum.name)
            XCTAssertNotNil(curriculum.label)
        } catch {
            XCTFail("Exception happened: \(error)")
        }
    }
    
    func testParsingWithInvalidJSONThrows() {
        XCTAssertThrowsError(try parser.getCVWith(dictionary: FileReader.getInvalidSampleDictionary()))
    }

    func testParsingWithEmptyJSONThrows() {
        XCTAssertThrowsError(try parser.getCVWith(dictionary: FileReader.getEmptySampleDictionary()))
    }
    
    func testGetManagedObjectWithValidEntityNameAndValidContext() {
        do {
            let context = CoreDataManager.shared.backgroundContext
            let dictionary = try FileReader.getValidSampleDictionary()
            let result: (NSManagedObject, [String: Any]) = try parser.managedObjectAndDictionaryWith(entityName: "Contact", jsonName: "contact", enclosingDictionary: dictionary, context: context)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("Exception caught: \(error)")
        }
    }
    
    func testGetManagedObjectThrowsOnInvalidEntityName() {
        do {
            let context = CoreDataManager.shared.backgroundContext
            let dictionary = try FileReader.getValidSampleDictionary()
            let _: (NSManagedObject, [String: Any]) = try parser.managedObjectAndDictionaryWith(entityName: "Dummy", jsonName: "dummy", enclosingDictionary: dictionary, context: context)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testDateWithValidString() {
        XCTAssertNotNil(try parser.dateWith(string: "2009-12-12"))
    }
    
    func testDateWithInvalidStringThrows() {
        XCTAssertThrowsError(try parser.dateWith(string: "12-2009-12-12"))
    }
    
    func testDateWithInvalidInput() {
        XCTAssertNil(try parser.dateWith(string: 1010))
    }
    
    func testDateWithEmptyStringThrows() {
        XCTAssertThrowsError(try parser.dateWith(string: ""))
    }
}
