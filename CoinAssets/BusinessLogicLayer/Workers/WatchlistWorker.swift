//
//  WatchlistWorker.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

protocol WatchlistWorkerProtocol {
    func fetchWatchlist(_ completion: @escaping ([Asset]?, String?) -> Void)
    func addToWatchlist(_ entity: Asset) -> Bool
    func deleteFromWatchlist(_ entity: Asset)
    func inWatchlist(_ entity: Asset) -> Bool
}

class WatchlistWorker: WatchlistWorkerProtocol {
    
    private var apiService: ApiServiceProtocol
    private var storageService: StorageServiceProtocol
    
    init(apiService: ApiServiceProtocol, storageService: StorageServiceProtocol) {
        self.apiService = apiService
        self.storageService = storageService
    }
    
    func fetchWatchlist(_ completion: @escaping ([Asset]?, String?) -> Void) {
        
        let objects: [AssetManaged] = self.storageService.getAll(by: "AssetManaged", predicate: nil)
        let ids = objects.compactMap { $0.id }.joined(separator: ",")
        
        guard ids.count > 0 else {
            completion([], nil)
            return
        }
        
        var parameters: [String: String] = [:]
        parameters["ids"] = ids
        
        self.apiService.getRequest(
            endPoint: "https://api.coincap.io/v2/assets",
            parameters: parameters) { (response: DataResponse<Asset>?, error: String?) in
            
            completion(response?.data, error)
        }
        
    }
    
    func addToWatchlist(_ entity: Asset) -> Bool {
        
        let object: AssetManaged? = self.storageService.add(by: "AssetManaged", fromEntity: entity)
        
        return object != nil
        
    }

    func deleteFromWatchlist(_ entity: Asset) {
        
        let predicate = NSPredicate(format: "id = %@", entity.id)
        self.storageService.delete(by: "AssetManaged", predicate: predicate)
        
    }
    
    func inWatchlist(_ entity: Asset) -> Bool {
        
        let predicate = NSPredicate(format: "id = %@", entity.id)
        let objects: [AssetManaged] = self.storageService.getAll(by: "AssetManaged", predicate: predicate)
        
        return objects.count > 0
        
    }
}
