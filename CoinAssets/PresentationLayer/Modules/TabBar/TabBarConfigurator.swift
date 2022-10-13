//
//  TabBarConfigurator.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

class TabBarConfigurator {

    static func configureModule() -> TabBarViewController {
        
        let viewController = TabBarViewController()
        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }

}
