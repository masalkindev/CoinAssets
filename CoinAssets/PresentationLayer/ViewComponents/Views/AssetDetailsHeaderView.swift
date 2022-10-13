//
//  AssetDetailsHeaderView.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

struct AssetDetailsHeaderViewModel {
    
    let price: String
    let percent: String
    let percentColor: String
    
    var chartPoints: [AssetDetailsChartPoint]?
}

class AssetDetailsHeaderView: UITableViewHeaderFooterView {

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var percentLabel: UILabel!
    @IBOutlet var chartView: AssetDetailsChartView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLabel.textColor = .primaryText
        
    }

    func configure(with model: AssetDetailsHeaderViewModel) {
        
        priceLabel.text = model.price
        percentLabel.text = model.percent
        percentLabel.textColor = UIColor(model.percentColor)
        
        if let points = model.chartPoints {
            if points.count > 1 {
                chartView.isHidden = false
                chartView.configure(with: points)
            } else {
                chartView.isHidden = true
            }
        } else {
            chartView.isHidden = false
            chartView.configure(with: [])
        }
    }
}
