//
//  UINavigationController+Appearance.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import UIKit

extension UINavigationController {
    
    func defaultAppearance() {
        
        let backgroundColor: UIColor = .tableBackground
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            navigationBar.standardAppearance = appearance
            
            let appearanceScroll = UINavigationBarAppearance()
            appearanceScroll.configureWithTransparentBackground()
            appearanceScroll.backgroundColor = backgroundColor
            navigationBar.scrollEdgeAppearance = appearanceScroll
            
        } else {
            navigationBar.barTintColor = backgroundColor
            navigationBar.shadowImage = UIImage()
        }

    }
}
