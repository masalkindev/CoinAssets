//
//  AssetsSharedPresenter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol AssetsSharedPresentationLogic {
    func presentListOfAsset(_ assets: [Asset]) -> [AssetTableViewModel]
}


class AssetsSharedPresenter: AssetsSharedPresentationLogic {
    
    func presentListOfAsset(_ assets: [Asset]) -> [AssetTableViewModel] {
        
        let models: [AssetTableViewModel] = assets.map {
            let price = Double($0.priceUsd ?? "") ?? 0
            let percent = Double($0.changePercent24Hr ?? "") ?? 0
            let iconUrl = "https://cryptoicons.org/api/color/\( $0.symbol.lowercased())/180/c7c7Cc7"
            return AssetTableViewModel(
                name: $0.name,
                symbol: $0.symbol,
                price: price.priceFormat,
                percent: percent.percentFormat,
                percentColor: percent.percentAssetColor,
                iconUrl: iconUrl)
        }
        
        return models
    }
}
