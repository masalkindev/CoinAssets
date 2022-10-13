//
//  StorageEntity.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

protocol StorageEntityCreating {
    associatedtype Entity
    func create(from entity: Entity)
}
