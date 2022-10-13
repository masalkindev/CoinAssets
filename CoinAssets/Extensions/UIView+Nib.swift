//
//  UIView+Nib.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import UIKit

extension UIView {

    static func loadViewFromNib<T: UIView>() -> T? {
        guard let name = T.description().components(separatedBy: ".").last else {
            return nil
        }
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
    }
    
}
