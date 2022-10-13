//
//  TabBarPresenter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol TabBarPresentationLogic {
    func presentTabs(response: [TabBarItem])
}

class TabBarPresenter: TabBarPresentationLogic {
    
    weak var viewController: TabBarDisplayLogic?
    
    func presentTabs(response: [TabBarItem]) {
        
        let viewControllers: [UIViewController] = response.map {
            
            let viewController: UIViewController
            let tabBarItem = UITabBarItem()
            
            switch $0 {
            case .assets:
                viewController = UINavigationController(
                    rootViewController: AssetsConfigurator.configureModule()
                )
                tabBarItem.title = NSLocalizedString("title_assets", comment: "")
                tabBarItem.image = UIImage(named: "bitcoinsign.circle.fill")
            case .watchlist:
                viewController = UINavigationController(
                    rootViewController: WatchlistConfigurator.configureModule()
                )
                tabBarItem.title = NSLocalizedString("title_watchlist", comment: "")
                tabBarItem.image = UIImage(named: "heart_fill")
            case .settings:
                viewController = UINavigationController(
                    rootViewController: SettingsConfigurator.configureModule()
                )
                tabBarItem.title =  NSLocalizedString("title_settings", comment: "")
                tabBarItem.image = UIImage(named: "gearshape.fill")
            }
            
            viewController.tabBarItem = tabBarItem
            
            return viewController
        }
        
        viewController?.displayTabs(viewControllers: viewControllers)
    }

}
