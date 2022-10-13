//
//  Data+Print.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

extension Data {
    
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
}
