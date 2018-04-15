//
//  FactsViewController.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FactsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var fact: Fact?
    
    let networkImageCache = NetworkCache()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(UINib(nibName: "FactsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "facts")
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
                    strongSelf.fact = fact
                    strongSelf.collectionView?.reloadData()
                case .failure(let error):
                    strongSelf.showAlert(message: error.userDescription)
                }
            }
        }
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fact?.rows?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "facts", for: indexPath) as! FactsCollectionViewCell
        let row = fact?.rows?[indexPath.item]
        cell.titleLabel?.text = row?.title
        cell.imageView.image = nil
        if let imageURL = row?.imageURL {
            cell.processActivityIndicatorView(isHidden: false)
            cell.imageView.setImage(cache: networkImageCache,
                                    imageURL: imageURL,
                                    completion: { result in
                                        DispatchQueue.main.async { [weak self] in
                                            guard self != nil else { return }
                                            cell.processActivityIndicatorView(isHidden: true)
                                            switch result {
                                            case .success(let data):
                                                cell.imageView.image = UIImage(data: data)
                                            case .failure:
                                                cell.imageView.image = UIImage(named: "noImage.jpeg")
                                            }
                                        }
            })
        } else {
            cell.imageView.image = UIImage(named: "noImage.jpeg")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        var insets: CGFloat = 0.0
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            insets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        }
        let size = self.view.frame.size.width / 2 - insets
        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "detail", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController,
            let cell = sender as? FactsCollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell)
        {
            viewController.factRow = fact?.rows?[indexPath.item]
            viewController.image = cell.imageView.image
        }
    }
   
}
