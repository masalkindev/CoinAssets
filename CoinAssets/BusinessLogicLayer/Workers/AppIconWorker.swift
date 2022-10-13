//
//  AppIconWorker.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

protocol AppIconWorkerProtocol {
    
    func fetchCurrentIcon() -> AppIcon
    func fetchIcons() -> [AppIcon]
    func selectCurrentIcon(_ icon: AppIcon)
}

class AppIconWorker: AppIconWorkerProtocol {
    
    func fetchCurrentIcon() -> AppIcon {
        
        let icon = UserDefaults.standard.string(forKey: "appIcon") ?? ""
        
        return AppIcon(rawValue: icon) ?? .white
    }
    
    func fetchIcons() -> [AppIcon] {
        [.white, .black, .yellow]
    }
    
    func selectCurrentIcon(_ icon: AppIcon) {
        UserDefaults.standard.set(icon.rawValue, forKey: "appIcon")
        UserDefaults.standard.synchronize()
    }

}
