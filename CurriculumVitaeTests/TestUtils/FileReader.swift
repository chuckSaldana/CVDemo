//
//  FileReader.swift
//  CurriculumVitaeTests
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
@testable import CurriculumVitae

struct FileReader {
    static func getValidSampleDictionary() throws -> [String: Any] {
        return try getGenericSampleDictionary(resourceName: "FeedSample")
    }
    
    static func getEmptySampleDictionary() throws -> [String: Any] {
        return try getGenericSampleDictionary(resourceName: "EmptySample")
    }
    
    static func getInvalidSampleDictionary() throws -> [String: Any] {
        return try getGenericSampleDictionary(resourceName: "InvalidFeedSample")
    }
    
    static func getGenericSampleDictionary(resourceName: String) throws -> [String: Any] {
        if let path = Bundle(for: ParserTests.self).url(forResource: resourceName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: Any] {
                    return jsonResult
                }
                throw ParsingError.jsonObjectNotFound
            } catch {
                throw error
            }
        }
        throw ParsingError.jsonFileNotFound
    }
}
