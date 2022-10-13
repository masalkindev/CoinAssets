//
//  Asset.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

struct Asset: Codable {

    let id: String
    let symbol: String
    let name: String
    let priceUsd: String?
    let supply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let changePercent24Hr: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case priceUsd
        case supply
        case marketCapUsd
        case volumeUsd24Hr
        case changePercent24Hr
    }

}
