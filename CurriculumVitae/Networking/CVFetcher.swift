//
//  CVFetcher.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

enum CVEndpoint: String {
    case basicCV = "https://gist.githubusercontent.com/chuckSaldana/ec59fb285a58850f690996317af81c28/raw/42a9cb12b335f48cf6ddecc089dabe92756a5acd/carlos.json"
}

struct CVFetcher: DataFetcher {
    
    func fetchCV(endpoint: CVEndpoint, completion: @escaping ([String: Any]) -> ()) {
        fetchData(urlStr: endpoint.rawValue, completion: completion)
    }
}
