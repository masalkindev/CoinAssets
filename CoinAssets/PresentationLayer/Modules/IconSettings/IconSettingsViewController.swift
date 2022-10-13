//
//  IconSettingsViewController.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import TableKit

protocol IconSettingsDisplayLogic: AnyObject {
    
    func displayIcons(with models: [PlainTableViewModel])
}

class IconSettingsViewController: UIViewController, IconSettingsDisplayLogic {
    
    @IBOutlet var tableView: UITableView!
    
    var interactor: IconSettingsBusinessLogic?
    
    private var tableDirector: TableDirector!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("title_icon", comment: "")
        navigationItem.largeTitleDisplayMode = .never
        
        setupTableView()
        
        interactor?.fetchIcons()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableDirector = TableDirector(tableView: tableView)
        tableView.backgroundColor = .tableBackground
    }
    
    // MARK: - Display protocol
    
    func displayIcons(with models: [PlainTableViewModel]) {
        
        let section = TableSection()
        section.headerHeight = 30
        section.footerHeight = CGFloat.leastNormalMagnitude
        
        let clickAction = TableRowAction<PlainTableViewCell>(.click) { [weak self] (options) in
            self?.interactor?.selectIcon(with: options.indexPath.row)
        }
        
        models.forEach {
            section += TableRow<PlainTableViewCell>(item: $0, actions: [clickAction])
        }
        
        tableDirector.clear()
        tableDirector += section
        tableDirector.reload()
        
        
    }
}
