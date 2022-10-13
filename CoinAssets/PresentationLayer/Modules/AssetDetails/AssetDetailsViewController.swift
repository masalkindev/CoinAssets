//
//  AssetDetailsViewController.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import TableKit

protocol AssetDetailsDisplayLogic: AnyObject {
    func displayTitle(with attrString: NSAttributedString)
    func displayHeart(with inWatchlist: Bool)
    func displayAsset(with headerModel: AssetDetailsHeaderViewModel, propertyModels: [PlainTableViewModel])
    func displayAlertError(with error: String)
}

class AssetDetailsViewController: UIViewController, AssetDetailsDisplayLogic {
    
    @IBOutlet var tableView: UITableView!
    
    var interactor: (AssetDetailsBusinessLogic & AssetDetailsDataStore)?
    
    private var tableDirector: TableDirector!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        setupTableView()
        
        interactor?.fetchAsset()
        interactor?.fetchAssetHistories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchWatchlist()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableDirector = TableDirector(tableView: tableView)
        tableView.backgroundColor = .tableBackground
    }
    
    // MARK: - Actions
    
    @objc func heartBarButtonItemTapped() {
        interactor?.watchlistEdit()
    }
    
    // MARK: - Display protocol
    
    func displayTitle(with attrString: NSAttributedString) {
        let titleLabel = UILabel()
        titleLabel.attributedText = attrString
        navigationItem.titleView = titleLabel
    }
    func displayHeart(with inWatchlist: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: inWatchlist ? UIImage(named: "heart_fill") : UIImage(named: "heart"),
            style: .plain,
            target: self,
            action: #selector(heartBarButtonItemTapped)
        )
    }
    func displayAsset(with headerModel: AssetDetailsHeaderViewModel, propertyModels: [PlainTableViewModel]) {
        
        let header = AssetDetailsHeaderView.loadViewFromNib() ?? AssetDetailsHeaderView()
        header.configure(with: headerModel)
        let section = TableSection(headerView: header, footerView: nil)
        section.headerHeight = getViewHeight(view: header, width: UIScreen.main.bounds.width)
        section.footerHeight = CGFloat.leastNormalMagnitude
        
        propertyModels.forEach {
            section += TableRow<PlainTableViewCell>(item: $0)
        }
        
        tableDirector.clear()
        tableDirector += section
        tableDirector.reload()
        
        
    }
    func displayAlertError(with error: String) {
        showAlert(title: NSLocalizedString("title_error", comment: ""), message: error)
    }
    
    private func getViewHeight(view: UIView, width: CGFloat) -> CGFloat {
        
        view.frame = CGRect(x: 0, y: 0, width: width, height: view.frame.size.height)
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        return view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
}
