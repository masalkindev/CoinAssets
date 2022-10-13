//
//  AssetManaged.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

extension AssetManaged: StorageEntityCreating {
    
    func create(from entity: Asset) {
        self.id = entity.id
    }
}
