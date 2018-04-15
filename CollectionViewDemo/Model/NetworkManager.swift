//
//  NetworkManager.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
