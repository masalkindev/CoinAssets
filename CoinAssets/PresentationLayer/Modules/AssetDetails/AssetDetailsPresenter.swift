//
//  AssetDetailsPresenter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol AssetDetailsPresentationLogic {
    func presentHeart(_ inWatchlist: Bool)
    func presentAssetDetails(_ asset: Asset, assetHistories: [AssetHistory]?)
    func presentAlertError(_ error: String)
}

class AssetDetailsPresenter: AssetDetailsPresentationLogic {
    
    weak var viewController: AssetDetailsDisplayLogic?
    
    func presentHeart(_ inWatchlist: Bool) {
        viewController?.displayHeart(with: inWatchlist)
    }
    func presentAssetDetails(_ asset: Asset, assetHistories: [AssetHistory]?) {
        
        let title = "\(asset.name) \(asset.symbol)"
        let range = NSString(string: title).range(of: asset.symbol)
        let titleAttr = NSMutableAttributedString(string: title)
        titleAttr.addAttribute(.foregroundColor, value: UIColor.primaryText, range: NSRange(location: 0, length: title.count))
        titleAttr.addAttribute(.font, value: UIFont.systemFont(ofSize: 17, weight: .semibold), range: NSRange(location: 0, length: title.count))
        titleAttr.addAttribute(.foregroundColor, value: UIColor.secondaryText, range: range)
        
        viewController?.displayTitle(with: titleAttr)
        
        let price = Double(asset.priceUsd ?? "") ?? 0
        let percent = Double(asset.changePercent24Hr ?? "") ?? 0
        
        let points: [AssetDetailsChartPoint]? = assetHistories?.compactMap {
            let value = Double($0.priceUsd)
            return value != nil ? AssetDetailsChartPoint(value: value!) : nil
        }
        
        let headerModel = AssetDetailsHeaderViewModel(
            price: price.priceFormat,
            percent: percent.percentFormat,
            percentColor: percent.percentAssetColor,
            chartPoints: points
        )
        
        var propertyModels: [PlainTableViewModel] = []
        if let marketCapUsd = asset.marketCapUsd, let value = Double(marketCapUsd) {
            propertyModels.append(
                PlainTableViewModel(
                    title: "Market Cap",
                    value: value.priceFormat,
                    accessory: .none
                )
            )
        }
        if let supply = asset.supply, let value = Double(supply) {
            propertyModels.append(
                PlainTableViewModel(
                    title: "Supply",
                    value: value.priceFormat,
                    accessory: .none
                )
            )
        }
        if let volumeUsd24Hr = asset.volumeUsd24Hr, let value = Double(volumeUsd24Hr) {
            propertyModels.append(
                PlainTableViewModel(
                    title: "Volume (24h)",
                    value: value.priceFormat,
                    accessory: .none
                )
            )
        }
        
        viewController?.displayAsset(with: headerModel, propertyModels: propertyModels)
    }
    func presentAlertError(_ error: String) {
        viewController?.displayAlertError(with: error)
    }
}
