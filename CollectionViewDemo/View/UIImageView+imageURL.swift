//
//  UIImageView+imageURL.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(cache: PersistantCache, imageURL: URL,
                  completion: ((Result<Data, CustomError>) -> Void)? = nil) {
        cache.add(url: imageURL, completion: completion)
    }
}
