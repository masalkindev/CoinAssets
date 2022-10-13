//
//  ListPlaceholderView.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

struct ListPlaceholderViewModel {
    
    let title: String
    let description: String
}

class ListPlaceholderView: UITableViewHeaderFooterView {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = .primaryText
        descriptionLabel.textColor = .secondaryText
        
    }

    func configure(with model: ListPlaceholderViewModel) {
        
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
