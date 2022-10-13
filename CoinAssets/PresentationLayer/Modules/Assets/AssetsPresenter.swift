//
//  AssetsPresenter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol AssetsPresentationLogic {
    func presentAsset(_ assets: [Asset])
    func presentAlertError(_ error: String)
}

class AssetsPresenter: AssetsPresentationLogic {
    
    weak var viewController: AssetsDisplayLogic?
    
    private let sharedPresenter: AssetsSharedPresentationLogic = AssetsSharedPresenter()
    
    func presentAsset(_ assets: [Asset]) {
        
        viewController?.displayAssets(with: sharedPresenter.presentListOfAsset(assets))
    }
    
    func presentAlertError(_ error: String) {
        viewController?.displayAlertError(with: error)
    }
}
