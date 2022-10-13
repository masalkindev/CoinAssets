//
//  SettingsInteractor.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

protocol SettingsBusinessLogic {
    
    func fetchSettings()
}

class SettingsInteractor: SettingsBusinessLogic {
    
    var presenter: SettingsPresentationLogic?
    
    private let appIconWorker: AppIconWorkerProtocol
    
    init(appIconWorker: AppIconWorkerProtocol) {
        self.appIconWorker = appIconWorker
    }
    
    func fetchSettings() {
        
        let currentIcon = appIconWorker.fetchCurrentIcon()
        
        presenter?.presentSettings([
            .icon(value: currentIcon)
        ])
    }

}
