//
//  FactsManager.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import Foundation

// wrapper class for fetching facts.
class FactsManager: NetworkManager {
    
    private struct Constants {
        static let factsURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }

    static func fetchFacts(completion: @escaping (Result<Fact, CustomError>) -> Void) {
        NetworkManager.responseObject(urlString: Constants.factsURL,
                                      completion: completion)
    }
}
