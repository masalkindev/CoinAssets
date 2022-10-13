//
//  PlainTableViewCell.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import TableKit

struct PlainTableViewModel {
    let title: String
    var value: String?
    var accessory: UITableViewCell.AccessoryType = .none
}

class PlainTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = .primaryText
        valueLabel.textColor = .secondaryText
        
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        selectionStyle = .none
    }
    
    func configure(with model: PlainTableViewModel) {
        
        titleLabel.text = model.title
        valueLabel.text = model.value
        accessoryType = model.accessory
        
    }
}
