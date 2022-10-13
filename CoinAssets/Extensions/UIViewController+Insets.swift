//
//  UIViewController+Insets.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import UIKit

extension UIViewController {
    
    var navBarHeight: CGFloat? {
        return navigationController?.navigationBar.frame.height
    }
    
    var tabBarHeight: CGFloat? {
        return tabBarController?.tabBar.frame.size.height
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    var topBarHeight: CGFloat {
        return statusBarHeight + (navBarHeight ?? 0)
    }
    
    var bottomBarHeight: CGFloat {
        return tabBarHeight ?? UIViewController.safeAreaInsets.bottom
    }
    
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        }
        return UIEdgeInsets.zero
    }
    
}
