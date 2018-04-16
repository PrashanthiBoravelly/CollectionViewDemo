//
//  FactsViewController.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

class FactsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DeviceAdopatble {
    
    // MARK: - Constants.
    
    let networkImageCache = NetworkCache()
    
    // MARK: - Variables.
    
    private var fact: Fact?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Life cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(UINib(nibName: "FactsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "facts")
        collectionView?.addSubview(refreshControl)
        showLoadingView()
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
    
    // MARK: - IBAction
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshFacts()
    }
    
    // MARK: - UICollectionViewDataSource
    
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
            
            // fecthing image from server.
            cell.imageView.setImage(cache: networkImageCache,
                                    imageURL: imageURL,
                                    completion: { result in
                                        DispatchQueue.main.async { [weak self] in
                                            guard self != nil else { return }
                                            switch result {
                                            case .success(let data):
                                                if let image = UIImage(data: data) {
                                                    cell.imageView.image = image
                                                } else {
                                                    cell.imageView.image = UIImage(named: "noImage.jpeg")
                                                }
                                            case .failure:
                                                cell.imageView.image = UIImage(named: "noImage.jpeg")
                                            }
                                            cell.processActivityIndicatorView(isHidden: true)
                                        }
            })
        } else {
            cell.imageView.image = UIImage(named: "noImage.jpeg")
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        var insets: CGFloat = 0.0
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            insets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        }
        let elementsCount = CGFloat(collectionViewElementsCount)
        let size = UIScreen.main.bounds.width / elementsCount - insets
        return CGSize(width: size, height: size)
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if let cell = cell as? FactsCollectionViewCell,
            cell.imageView.image != nil
        {
            performSegue(withIdentifier: "detail", sender: cell)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController,
            let cell = sender as? FactsCollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell)
        {
            viewController.factRow = fact?.rows?[indexPath.item]
            viewController.image = cell.imageView.image
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
}
