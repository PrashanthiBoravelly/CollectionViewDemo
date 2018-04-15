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
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.addSubview(refreshControl)
        showLoadingView()
        refreshFacts()
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshFacts()
    }
    
    private func refreshFacts() {
        FactsManager.fetchFacts { result in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.hideLoadingView()
                strongSelf.refreshControl.endRefreshing()
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
