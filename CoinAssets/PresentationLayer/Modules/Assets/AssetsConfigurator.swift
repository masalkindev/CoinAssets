//
//  AssetsConfigurator.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

class AssetsConfigurator {

    static func configureModule() -> AssetsViewController {
        
        let apiService =  Dependencies.shared.apiService
        
        let assetsWorker = AssetsWorker(apiService: apiService)
        
        let viewController = AssetsViewController(style: .grouped)
        let interactor = AssetsInteractor(assetsWorker: assetsWorker)
        let presenter = AssetsPresenter()
        let router = AssetsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }

}
