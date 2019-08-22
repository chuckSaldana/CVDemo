//
//  DataFetcher.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

enum DataFetcherError: Error {
    case malformedURL
}

protocol DataFetcher {
}

extension DataFetcher {
    func fetchData(urlStr: String, completion: @escaping ([String: Any]) -> ()) throws {
        // Set up the URL request
        guard let url = URL(string: urlStr) else {
            throw DataFetcherError.malformedURL
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("Error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                
                completion(todo)

            } catch let error {
                print("error trying to convert data to JSON: \(error)")
                return
            }
        }
        task.resume()
    }
}
