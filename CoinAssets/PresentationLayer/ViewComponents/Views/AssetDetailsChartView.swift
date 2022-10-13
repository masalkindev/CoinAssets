//
//  AssetDetailsChartView.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import Charts

struct AssetDetailsChartPoint {
    
    let value: Double
}

class AssetDetailsChartView: XibView {

    @IBOutlet var chartView: LineChartView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .medium
        } else {
            activityIndicatorView.style = .gray
        }
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        
        setupChart()
    }
    
    func configure(with points: [AssetDetailsChartPoint]) {
        
        if points.count == 0 {
            activityIndicatorView.startAnimating()
            chartView.isHidden = true
        } else {
            activityIndicatorView.stopAnimating()
            chartView.isHidden = false
            
            var maxValue = points.first?.value ?? 0
            var minValue = maxValue
            points.forEach { point in
                if point.value > maxValue {
                    maxValue = point.value
                }
                if point.value < minValue {
                    minValue = point.value
                }
            }
            
            let entries: [ChartDataEntry] = points.enumerated().compactMap {
                ChartDataEntry(x: Double($0), y: $1.value)
            }
            
            let lineDataSet = LineChartDataSet(entries: entries, label: "line")
            lineDataSet.colors = [.primaryText]
            lineDataSet.lineWidth = 2.0
            lineDataSet.drawCirclesEnabled = false
            lineDataSet.mode = .linear
            lineDataSet.drawValuesEnabled = false
            
            let minLimit = ChartLimitLine(limit: minValue, label: minValue.priceFormat)
            minLimit.lineWidth = 0
            minLimit.lineColor = .clear
            minLimit.labelPosition = .leftBottom
            minLimit.xOffset = 20
            minLimit.yOffset = 2
            minLimit.valueFont = .systemFont(ofSize: 13)
            minLimit.valueTextColor = .secondaryText

            let maxLimit = ChartLimitLine(limit: maxValue, label: maxValue.priceFormat)
            maxLimit.lineWidth = 0
            maxLimit.lineColor = .clear
            maxLimit.labelPosition = .rightTop
            maxLimit.xOffset = 20
            maxLimit.yOffset = 2
            maxLimit.valueFont = .systemFont(ofSize: 13)
            maxLimit.valueTextColor = .secondaryText
            
            let leftAxis = chartView.leftAxis
            leftAxis.removeAllLimitLines()
            leftAxis.addLimitLine(minLimit)
            leftAxis.addLimitLine(maxLimit)
            
            let data = LineChartData(dataSet: lineDataSet)
            
            chartView.data = data
            chartView.animate(xAxisDuration: 0.5)
        }
        
    }
    
    private func setupChart() {
        chartView.setScaleEnabled(false)
        chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.xAxis.enabled = true
        chartView.xAxis.drawLabelsEnabled = false
        chartView.leftAxis.enabled = true
        chartView.rightAxis.enabled = false
        chartView.leftAxis.drawZeroLineEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.legend.enabled = false
        chartView.isUserInteractionEnabled = false
        chartView.minOffset = 0
    }

}
