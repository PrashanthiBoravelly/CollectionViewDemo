//
//  PersistantCache.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import Foundation

class PersistantCache<T> {
    
    var values: [URL: T] = [:]
    
    enum CodingKeys: String, CodingKey {
        case values
    }
    
    func add(url: URL, completion: @escaping (T) -> Void) {
        if let value = values[url] {
            completion(value)
        } else {
            URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { [weak self]  (data, _, error) in
                guard let strongSelf = self else { return }
                if error == nil,
                    let data = data as? T
                {
                    strongSelf.values[url] = data
                    completion(data)
                }
            }).resume()
        }
    }
}
