//
//  WatchlistViewController.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import TableKit

protocol WatchlistDisplayLogic: AnyObject {
    func displayAssets(with models: [AssetTableViewModel])
    func displayDeleteAsset(with row: Int)
    func displayAlertError(with error: String)
}

class WatchlistViewController: UITableViewController, WatchlistDisplayLogic {
    
    var interactor: (WatchlistBusinessLogic & AssetsDataStore)?
    var router: AssetsRoutingLogic?
    
    private var tableDirector: TableDirector!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.defaultAppearance()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = NSLocalizedString("title_watchlist", comment: "")
        
        setupTableView()
        
        setupRefreshControl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchAssets()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableDirector = TableDirector(tableView: tableView)
        tableView.backgroundColor = .tableBackground
    }
    
    private func setupRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    // MARK: - Actions
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        interactor?.fetchAssets()
    }
    
    // MARK: - Display protocol
    
    func displayAssets(with models: [AssetTableViewModel]) {
        
        guard models.count > 0 else {
            
            let header = ListPlaceholderView.loadViewFromNib() ?? ListPlaceholderView()
            let headerModel = ListPlaceholderViewModel(
                title: NSLocalizedString("placeholder_watchlist_title", comment: ""),
                description: NSLocalizedString("placeholder_watchlist_description", comment: "")
            )
            header.configure(with: headerModel)
            let section = TableSection(headerView: header, footerView: nil)
            section.headerHeight = (UIScreen.main.bounds.height - bottomBarHeight) * 0.7
            section.footerHeight = CGFloat.leastNormalMagnitude
            
            tableDirector.clear()
            tableDirector += section
            tableDirector.reload()
            
            refreshControl?.endRefreshing()
            
            return
        }
        
        let section = TableSection()
        
        let clickAction = TableRowAction<AssetTableViewCell>(.click) { [weak self] (options) in
            self?.router?.routeAssetDetails(row: options.indexPath.row, dataSource: self?.interactor)
        }
        let deleteAction = TableRowAction<AssetTableViewCell>(.clickDelete) { [weak self] (options) in
            section.remove(rowAt: options.indexPath.row)
            self?.interactor?.deleteAsset(with: options.indexPath.row)
        }
        
        let canDeleteAction = TableRowAction<AssetTableViewCell>(.canDelete) { _ in
            return true
        }
        
        section.headerHeight = CGFloat.leastNormalMagnitude
        section.footerHeight = CGFloat.leastNormalMagnitude
        models.forEach {
            section += TableRow<AssetTableViewCell>(item: $0, actions: [clickAction, deleteAction, canDeleteAction])
        }
        
        tableDirector.clear()
        tableDirector += section
        tableDirector.reload()
        
        refreshControl?.endRefreshing()
    }
    
    func displayDeleteAsset(with row: Int) {
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func displayAlertError(with error: String) {
        showAlert(title: NSLocalizedString("title_error", comment: ""), message: error)
    }
}
