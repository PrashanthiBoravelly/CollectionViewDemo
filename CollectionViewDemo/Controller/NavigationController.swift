//
//  NavigationController.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .black
        navigationBar.barTintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray,
                                             NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20.0)!]
    }
    
    // Creating empty backButtonItem in every viewcontroller before pushing VC.
    func createEmptyBackBarButtonItem() {
        topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        createEmptyBackBarButtonItem()
        super.show(vc, sender: sender)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        createEmptyBackBarButtonItem()
        super.pushViewController(viewController, animated: animated)
    }
    
}
