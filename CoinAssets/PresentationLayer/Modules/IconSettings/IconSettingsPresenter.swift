//
//  IconSettingsPresenter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol IconSettingsPresentationLogic {
    
    func presentIcons(_ icons: [AppIcon], currentIcon: AppIcon)
}

class IconSettingsPresenter: IconSettingsPresentationLogic {
    
    weak var viewController: IconSettingsDisplayLogic?
    
    func presentIcons(_ icons: [AppIcon], currentIcon: AppIcon) {
        
        let models = icons.map {
            PlainTableViewModel(title: $0.rawValue, accessory: $0 == currentIcon ? .checkmark : .none)
        }
        
        viewController?.displayIcons(with: models)
    }
    
}
