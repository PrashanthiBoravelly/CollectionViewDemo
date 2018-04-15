//
//  NetworkCache.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import Foundation

class NetworkCache {
    
    var values: [URL: Data] = [:]
    
    enum CodingKeys: String, CodingKey {
        case values
    }
    
    func add(url: URL, completion: ((Result<Data, CustomError>) -> Void)? = nil) {
        if let value = values[url] {
            completion?(.success(value))
        } else {
            URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { [weak self]  (data, _, error) in
                guard let strongSelf = self else { return }
                switch (data, error) {
                case(_, let error?):
                    let error = CustomError.system(error: error)
                    completion?(.failure(error))
                case(let data?, nil):
                    strongSelf.values[url] = data
                    completion?(.success(data))
                default:
                    let error = CustomError.unknown
                    completion?(.failure(error))
                }
            }).resume()
        }
    }
}
