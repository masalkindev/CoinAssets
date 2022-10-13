//
//  UITabBarController+Appearance.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import UIKit

extension UITabBarController {
    
    func defaultAppearance() {
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
}
