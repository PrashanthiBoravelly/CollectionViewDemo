//
//  DetailViewController.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DeviceAdopatble {
    
    // MARK: - Variables.
    
    var factRow: Fact.Row?
    var image: UIImage?
    
    // MARK: - IBOutlets.
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private var widthConstraint: NSLayoutConstraint?

    // MARK: - Life cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = factRow?.title
        descriptionLabel.text = factRow?.description
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: descriptionLabelFontSize)
        imageView.image = image
        widthConstraint?.constant = image?.size.width ?? 100.0
    }
    
    override public var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isPortrait {
            return UITraitCollection(traitsFrom:[UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        }
        return super.traitCollection
    }
}
