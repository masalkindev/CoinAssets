//
//  IconSettingsInteractor.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol IconSettingsBusinessLogic {
    
    func fetchIcons()
    func selectIcon(with row: Int)
}

class IconSettingsInteractor: IconSettingsBusinessLogic {
    
    var presenter: IconSettingsPresentationLogic?
    
    private var fetchedIcons: [AppIcon] = []
    
    private let appIconWorker: AppIconWorkerProtocol
    
    init(appIconWorker: AppIconWorkerProtocol) {
        self.appIconWorker = appIconWorker
    }

    func fetchIcons() {
        let currentIcon = appIconWorker.fetchCurrentIcon()
        fetchedIcons = appIconWorker.fetchIcons()
        
        presenter?.presentIcons(fetchedIcons, currentIcon: currentIcon)
    }
    
    func selectIcon(with row: Int) {
        let icon = fetchedIcons[row]
        
        if UIApplication.shared.supportsAlternateIcons {
            let nameIcon: String?
            switch icon {
            case .white:
                nameIcon = nil
            case .black:
                nameIcon = "Black"
            case .yellow:
                nameIcon = "Yellow"
            }
            
            UIApplication.shared.setAlternateIconName(nameIcon)
            
            appIconWorker.selectCurrentIcon(icon)
            presenter?.presentIcons(fetchedIcons, currentIcon: icon)
            
        }
    }
}
