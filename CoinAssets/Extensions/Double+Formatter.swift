//
//  Double+Formatter.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

extension Double {

    private static let priceFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        formatter.groupingSeparator = ","
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        
        return formatter
    }()
    
    private static let percentFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.positivePrefix = "+"
        formatter.negativePrefix = "-"
        
        return formatter
    }()
    
    var priceFormat: String {
        
        let number = NSNumber(value: self)
        
        return "$\(Double.priceFormatter.string(from: number) ?? "")"
    }
    
    var percentFormat: String {
        
        let number = NSNumber(value: self)
        
        return "\(Double.percentFormatter.string(from: number) ?? "")%"
    }
    
    var percentAssetColor: String {
        self >= 0 ? "#34C759" : "#FF3B30"
    }
}
