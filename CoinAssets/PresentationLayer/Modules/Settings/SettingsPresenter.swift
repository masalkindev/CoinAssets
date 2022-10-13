//
//  SettingsPresenter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol SettingsPresentationLogic {
    
    func presentSettings(_ items: [SettingsItem])
}

class SettingsPresenter: SettingsPresentationLogic {
    
    weak var viewController: SettingsDisplayLogic?
    
    func presentSettings(_ items: [SettingsItem]) {
        
        let models: [PlainTableViewModel] = items.map {
            switch $0 {
            case let .icon(value):
                return PlainTableViewModel(
                    title: NSLocalizedString("title_icon", comment: ""),
                    value: value.rawValue,
                    accessory: .disclosureIndicator
                )
            }
        }
        
        viewController?.displaySettings(with: models)
    }
    
}
