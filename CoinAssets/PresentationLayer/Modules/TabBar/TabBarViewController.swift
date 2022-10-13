//
//  TabBarViewController.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

protocol TabBarDisplayLogic: AnyObject {
    func displayTabs(viewControllers: [UIViewController])
}

class TabBarViewController: UITabBarController, TabBarDisplayLogic {
    
    var interactor: TabBarBusinessLogic?

    override func viewDidLoad() {
        super.viewDidLoad()

        defaultAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchTabs()
    }
    
    // MARK: - Display protocol
    
    func displayTabs(viewControllers: [UIViewController]) {
        
        self.viewControllers = viewControllers
    }
}
