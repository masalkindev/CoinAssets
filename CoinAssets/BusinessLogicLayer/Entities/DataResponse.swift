//
//  DataResponse.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

struct DataResponse<L: Codable>: Codable {
    
    let data: [L]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
