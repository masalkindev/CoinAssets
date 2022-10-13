//
//  IconSettingsConfigurator.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

class IconSettingsConfigurator {

    static func configureModule() -> IconSettingsViewController {
        
        let appIconWorker = AppIconWorker()
        
        let viewController = IconSettingsViewController()
        let interactor = IconSettingsInteractor(appIconWorker: appIconWorker)
        let presenter = IconSettingsPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }

}
