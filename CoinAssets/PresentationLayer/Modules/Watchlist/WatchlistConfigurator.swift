//
//  WatchlistConfigurator.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

class WatchlistConfigurator {

    static func configureModule() -> WatchlistViewController {
        
        let apiService =  Dependencies.shared.apiService
        let storageService = Dependencies.shared.storageService
        
        let watchlistWorker = WatchlistWorker(apiService: apiService, storageService: storageService)
        
        let viewController = WatchlistViewController(style: .grouped)
        let interactor = WatchlistInteractor(watchlistWorker: watchlistWorker)
        let presenter = WatchlistPresenter()
        let router = AssetsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }

}
