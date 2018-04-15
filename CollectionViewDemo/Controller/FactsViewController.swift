//
//  FactsViewController.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FactsViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView()
        refreshFacts()
    }
    
    private func refreshFacts() {
        FactsManager.fetchFacts { result in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.hideLoadingView()
                switch result {
                case .success(let fact):
                    print(fact.title)
                    strongSelf.collectionView?.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
   
    
   
}
