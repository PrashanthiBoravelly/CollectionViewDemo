//
//  NetworkCache.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import Foundation

class NetworkCache: NetworkManager {
    
    var values: [String: Data] = [:]
    
    enum CodingKeys: String, CodingKey {
        case values
    }
    
    func add(urlString: String, completion: ((Result<Data, CustomError>) -> Void)? = nil) {
        if let value = values[urlString] {
            completion?(.success(value))
        } else {
            NetworkCache.responseData(urlString: urlString) { result in
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    switch result {
                    case .success(let data):
                        strongSelf.values[urlString] = data
                        completion?(.success(data))
                    case .failure(let error):
                        completion?(.failure(error))
                        
                    }
                }
            }
        }
    }
    
}
