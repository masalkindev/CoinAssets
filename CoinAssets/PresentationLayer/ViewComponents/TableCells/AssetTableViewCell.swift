//
//  AssetTableViewCell.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import TableKit

struct AssetTableViewModel {
    let name: String
    let symbol: String
    let price: String
    let percent: String
    let percentColor: String
    let iconUrl: String
}

class AssetTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var percentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = 30
        iconImageView.clipsToBounds = true
        iconImageView.backgroundColor = .iconBackground
        
        nameLabel.textColor = .primaryText
        symbolLabel.textColor = .secondaryText
        priceLabel.textColor = .secondaryText
        
        separatorInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 0)
        selectionStyle = .none
    }
    
    func configure(with model: AssetTableViewModel) {
        
        iconImageView.load(with: model.iconUrl)
        nameLabel.text = model.name
        symbolLabel.text = model.symbol
        priceLabel.text = model.price
        percentLabel.text = model.percent
        percentLabel.textColor = UIColor(model.percentColor)
        
    }
}
