//
//  TabBarInteractor.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Foundation

protocol TabBarBusinessLogic {
    func fetchTabs()
}

class TabBarInteractor: TabBarBusinessLogic {
    
    var presenter: TabBarPresentationLogic?

    func fetchTabs() {
        
        let tabs: [TabBarItem] = [.assets, .watchlist, .settings]
        
        presenter?.presentTabs(response: tabs)
    }

}
