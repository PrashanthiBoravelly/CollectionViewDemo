//
//  DeviceAdoptable.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 16/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import UIKit

protocol DeviceAdopatble: class {}
extension DeviceAdopatble {
    
    var isiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var isLandScape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
    var navigationBarTitleFontSize: CGFloat {
        return isiPad ? 32.0 : 20.0
    }
    
    var descriptionLabelFontSize: CGFloat {
        return isiPad ? 25.0 : 15.0
    }
    
    var collectionViewElementsCount: Int {
        return isLandScape ? 3 : 2
    }
}
