//
//  AssetsInteractor.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

protocol AssetsBusinessLogic {
    func fetchAssets()
    func fetchNextPageAssets(with row: Int)
    func searchAssets(with query: String?)
}

protocol AssetsDataStore {
    var assets: [Asset] { get }
}

class AssetsInteractor: NSObject, AssetsBusinessLogic, AssetsDataStore {
    
    var presenter: AssetsPresentationLogic?
    
    private let assetsWorker: AssetsWorkerProtocol

    private var fetchedAssets: [Asset] = []
    
    private var page: Int = 1
    private var stopLoadNextPage: Bool = false
    
    private var query: String?
    
    init(assetsWorker: AssetsWorkerProtocol) {
        self.assetsWorker = assetsWorker
    }
    
    var assets: [Asset] {
        fetchedAssets
    }
    
    @objc func fetchAssets() {
        
        page = 1
        stopLoadNextPage = false
        
        assetsWorker.fetchAssets(by: page, query: query) { [weak self] assets, error in
            guard error == nil else {
                self?.presenter?.presentAlertError(error!)
                return
            }
            self?.fetchedAssets = assets ?? []
            self?.presentAssets()
        }
    }
    
    func fetchNextPageAssets(with row: Int) {
        guard !stopLoadNextPage, row == fetchedAssets.count - 1 else {
            return
        }
        
        page += 1
        
        assetsWorker.fetchAssets(by: page, query: query) { [weak self] assets, error in
            self?.fetchedAssets.append(contentsOf: assets ?? [])
            if assets?.count ?? 0 == 0 {
                self?.stopLoadNextPage = true
            }
            self?.presentAssets()
        }
    }
    
    func searchAssets(with query: String?) {
        self.query = query
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchAssets), object: nil)
        self.perform(#selector(fetchAssets), with: nil, afterDelay: 0.33)
    }
    
    private func presentAssets() {
        
        presenter?.presentAsset(fetchedAssets)
    }
}
