//
//  SettingsConfigurator.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

class SettingsConfigurator {

    static func configureModule() -> SettingsViewController {
        
        let appIconWorker = AppIconWorker()
        
        let viewController = SettingsViewController()
        let interactor = SettingsInteractor(appIconWorker: appIconWorker)
        let presenter = SettingsPresenter()
        let router = SettingsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }

}
