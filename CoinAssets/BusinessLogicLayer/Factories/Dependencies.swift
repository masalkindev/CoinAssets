//
//  Dependencies.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 13.10.2022.
//

import Foundation

class Dependencies {

    static var shared = Dependencies()

    private init() {
    }
    
    lazy var apiService: ApiServiceProtocol = {
        ApiService()
    }()
    
    lazy var storageService: StorageServiceProtocol = {
        StorageService()
    }()
}
