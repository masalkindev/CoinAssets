//
//  UIColor+Theme.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import UIKit

extension UIColor {
    
    static var primaryText: UIColor {
        
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    static var secondaryText: UIColor {
        
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .gray
        }
    }
    
    static var tableBackground: UIColor {
        
        if #available(iOS 13.0, *) {
            return UIColor(named: "TableBackground") ?? .systemGroupedBackground
        } else {
            return UIColor("#F2F2F2")
        }
    }
    
    static var iconBackground: UIColor {
        UIColor("#C7C7C7")
    }
    
}
