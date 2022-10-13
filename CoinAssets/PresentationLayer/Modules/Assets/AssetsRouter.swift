//
//  AssetsRouter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol AssetsRoutingLogic {
    func routeAssetDetails(row: Int, dataSource: AssetsDataStore?)
}

class AssetsRouter: AssetsRoutingLogic {
    
    weak var viewController: UIViewController?

    func routeAssetDetails(row: Int, dataSource: AssetsDataStore?) {
        
        let assetDetailsViewController = AssetDetailsConfigurator.configureModule()
        var assetDetailsDataStore = assetDetailsViewController.interactor
        assetDetailsDataStore?.asset = dataSource?.assets[row]
        
        viewController?.navigationController?.pushViewController(assetDetailsViewController, animated: true)
    }

}
