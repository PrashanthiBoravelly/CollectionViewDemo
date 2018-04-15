//
//  DetailViewController.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var factRow: Fact.Row?
    var image: UIImage?
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = factRow?.title
        descriptionLabel.text = factRow?.description
        imageView.image = image
    }
}
