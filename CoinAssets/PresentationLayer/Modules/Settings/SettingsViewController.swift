//
//  SettingsViewController.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import TableKit

protocol SettingsDisplayLogic: AnyObject {
    func displaySettings(with models: [PlainTableViewModel])
}

class SettingsViewController: UIViewController, SettingsDisplayLogic {
    
    @IBOutlet var tableView: UITableView!
    
    var interactor: SettingsBusinessLogic?
    var router: SettingsRoutingLogic?
    
    private var tableDirector: TableDirector!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.defaultAppearance()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = NSLocalizedString("title_settings", comment: "")
        
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchSettings()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableDirector = TableDirector(tableView: tableView)
        tableView.backgroundColor = .tableBackground
    }
    
    
    // MARK: - Display protocol
    
    func displaySettings(with models: [PlainTableViewModel]) {
        
        let section = TableSection()
        section.headerHeight = 10
        section.footerHeight = CGFloat.leastNormalMagnitude
        
        let clickAction = TableRowAction<PlainTableViewCell>(.click) { [weak self] (options) in
            self?.router?.routeIconSettings()
        }
        
        models.forEach {
            section += TableRow<PlainTableViewCell>(item: $0, actions: [clickAction])
        }
        
        tableDirector.clear()
        tableDirector += section
        tableDirector.reload()
        
        
    }
}
