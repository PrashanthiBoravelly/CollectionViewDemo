//
//  Fact.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    let title: String
    let rows: [Row]?
    struct Row: Decodable {
        let title: String?
        let description: String?
        let imageURL: URL?
        
        enum CodingKeys: String, CodingKey {
            case title
            case description
            case imageURL = "imageHref"
        }
    }
}
