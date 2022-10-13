//
//  WatchlistInteractor.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

protocol WatchlistBusinessLogic {
    func fetchAssets()
    func deleteAsset(with row: Int)
}

class WatchlistInteractor: WatchlistBusinessLogic, AssetsDataStore {
    
    var presenter: WatchlistPresentationLogic?

    private let watchlistWorker: WatchlistWorkerProtocol

    private var fetchedAssets: [Asset] = []
    
    init(watchlistWorker: WatchlistWorkerProtocol) {
        self.watchlistWorker = watchlistWorker
    }
    
    var assets: [Asset] {
        fetchedAssets
    }
    
    @objc func fetchAssets() {
        
        watchlistWorker.fetchWatchlist() { [weak self] assets, error in
            guard error == nil else {
                self?.presenter?.presentAlertError(error!)
                return
            }
            self?.fetchedAssets = assets ?? []
            self?.presentAssets()
        }
    }
    
    func deleteAsset(with row: Int) {
        
        let asset = fetchedAssets[row]
        
        watchlistWorker.deleteFromWatchlist(asset)
        
        fetchedAssets.remove(at: row)
        
        if fetchedAssets.count == 0 {
            presentAssets()
        } else {
            presenter?.presentDelete(row)
        }
    }
    
    private func presentAssets() {
        
        presenter?.presentAsset(fetchedAssets)
    }
}
