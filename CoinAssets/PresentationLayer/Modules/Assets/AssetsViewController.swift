//
//  AssetsViewController.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import TableKit

protocol AssetsDisplayLogic: AnyObject {
    func displayAssets(with models: [AssetTableViewModel])
    func displayAlertError(with error: String)
}

class AssetsViewController: UITableViewController, AssetsDisplayLogic {
    
    var interactor: (AssetsBusinessLogic & AssetsDataStore)?
    var router: AssetsRoutingLogic?
    
    private var tableDirector: TableDirector!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.defaultAppearance()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = NSLocalizedString("title_assets", comment: "")
        
        setupTableView()
        
        setupSearchController()
        
        setupRefreshControl()
        
        interactor?.fetchAssets()
        
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableDirector = TableDirector(tableView: tableView)
        tableView.backgroundColor = .tableBackground
    }
    
    private func setupSearchController() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        
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
        
        let clickAction = TableRowAction<AssetTableViewCell>(.click) { [weak self] (options) in
            self?.router?.routeAssetDetails(row: options.indexPath.row, dataSource: self?.interactor)
        }
        let willDisplayAction = TableRowAction<AssetTableViewCell>(.willDisplay) { [weak self] (options) in
            self?.interactor?.fetchNextPageAssets(with: options.indexPath.row)
        }
        
        let section = TableSection()
        section.headerHeight = CGFloat.leastNormalMagnitude
        section.footerHeight = CGFloat.leastNormalMagnitude
        models.forEach {
            section += TableRow<AssetTableViewCell>(item: $0, actions: [clickAction, willDisplayAction])
        }
        
        tableDirector.clear()
        tableDirector += section
        tableDirector.reload()
        
        refreshControl?.endRefreshing()
    }
    
    func displayAlertError(with error: String) {
        showAlert(title: NSLocalizedString("title_error", comment: ""), message: error)
    }
}

extension AssetsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        interactor?.searchAssets(with: searchBar.text)
    }
}

