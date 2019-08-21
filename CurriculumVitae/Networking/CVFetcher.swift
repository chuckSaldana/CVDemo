//
//  CVFetcher.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

enum CVEndpoint: String {
    case basicCV = "https://gist.githubusercontent.com/chuckSaldana/ec59fb285a58850f690996317af81c28/raw/eeaaa5a561452013f5ff982eb7a16a405ba317f5/carlos.json"
}

struct CVFetcher: DataFetcher {
    
    func fetchCV(endpoint: CVEndpoint, completion: @escaping ([String: Any]) -> ()) {
        fetchData(urlStr: endpoint.rawValue, completion: completion)
    }
}
