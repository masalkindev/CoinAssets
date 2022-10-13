//
//  SettingsRouter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol SettingsRoutingLogic {
    func routeIconSettings()
}

class SettingsRouter: SettingsRoutingLogic {
    
    weak var viewController: UIViewController?

    func routeIconSettings() {
        
        let iconSettingsViewController = IconSettingsConfigurator.configureModule()
        
        viewController?.navigationController?.pushViewController(iconSettingsViewController, animated: true)
    }

}
