//
//  WatchlistPresenter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol WatchlistPresentationLogic {
    func presentAsset(_ assets: [Asset])
    func presentDelete(_ row: Int)
    func presentAlertError(_ error: String)
}

class WatchlistPresenter: WatchlistPresentationLogic {
    
    weak var viewController: WatchlistDisplayLogic?
    
    private let sharedPresenter: AssetsSharedPresentationLogic = AssetsSharedPresenter()
    
    func presentAsset(_ assets: [Asset]) {
        
        viewController?.displayAssets(with: sharedPresenter.presentListOfAsset(assets))
    }
    
    func presentDelete(_ row: Int) {
        viewController?.displayDeleteAsset(with: row)
    }
    
    func presentAlertError(_ error: String) {
        viewController?.displayAlertError(with: error)
    }
}
