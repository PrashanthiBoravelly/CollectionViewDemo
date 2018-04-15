//
//  UIViewController+Loading.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoadingView() {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.startAnimating()
        let barButtonItem = UIBarButtonItem(customView: activityIndicatorView)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    func hideLoadingView() {
        navigationItem.rightBarButtonItem = nil
    }
}
