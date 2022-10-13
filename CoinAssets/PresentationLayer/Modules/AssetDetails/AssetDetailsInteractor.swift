//
//  AssetDetailsInteractor.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

protocol AssetDetailsBusinessLogic {
    func fetchWatchlist()
    func fetchAsset()
    func fetchAssetHistories()
    func watchlistEdit()
}

protocol AssetDetailsDataStore {
    var asset: Asset! { get set }
    var assetHistories: [AssetHistory] { get }
}

class AssetDetailsInteractor: AssetDetailsBusinessLogic, AssetDetailsDataStore {

    var presenter: AssetDetailsPresentationLogic?

    var asset: Asset!
    var assetHistories: [AssetHistory] {
        []
    }
    
    private let watchlistWorker: WatchlistWorkerProtocol
    private let assetHistoriesWorker: AssetHistoriesWorkerProtocol

    private var fetchedAssetHistories: [AssetHistory] = []
    
    private var inWatchlist: Bool = false
    
    init(watchlistWorker: WatchlistWorkerProtocol, assetHistoriesWorker: AssetHistoriesWorkerProtocol) {
        self.watchlistWorker = watchlistWorker
        self.assetHistoriesWorker = assetHistoriesWorker
    }
    
    func fetchWatchlist() {
        
        inWatchlist = watchlistWorker.inWatchlist(asset)
        presenter?.presentHeart(inWatchlist)
    }
    
    func fetchAsset() {
        
        presenter?.presentAssetDetails(asset, assetHistories: nil)
    }
    func fetchAssetHistories() {
        assetHistoriesWorker.fetchAssetHistories(by: asset.id) { [weak self] histories, error in
            if let error = error {
                self?.presenter?.presentAlertError(error)
            }
            self?.fetchedAssetHistories = histories ?? []
            self?.presentAsset()
            
        }
    }
    func watchlistEdit() {
        if inWatchlist {
            watchlistWorker.deleteFromWatchlist(asset)
            inWatchlist = false
        } else {
            inWatchlist = watchlistWorker.addToWatchlist(asset)
        }
        
        presenter?.presentHeart(inWatchlist)
    }
    
    private func presentAsset() {
        
        presenter?.presentAssetDetails(asset, assetHistories: fetchedAssetHistories)
    }
}
