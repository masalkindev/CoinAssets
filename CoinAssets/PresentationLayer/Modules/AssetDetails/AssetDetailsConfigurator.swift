//
//  AssetDetailsConfigurator.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

class AssetDetailsConfigurator {

    static func configureModule() -> AssetDetailsViewController {
        
        let apiService =  Dependencies.shared.apiService
        let storageService = Dependencies.shared.storageService
        
        let watchlistWorker = WatchlistWorker(apiService: apiService, storageService: storageService)
        let assetHistoriesWorker = AssetHistoriesWorker(apiService: apiService)
        
        let viewController = AssetDetailsViewController()
        let interactor = AssetDetailsInteractor(
            watchlistWorker: watchlistWorker,
            assetHistoriesWorker: assetHistoriesWorker
        )
        let presenter = AssetDetailsPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }

}
