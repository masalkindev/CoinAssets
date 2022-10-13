//
//  AssetHistoriesWorker.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

protocol AssetHistoriesWorkerProtocol {
    
    func fetchAssetHistories(by id: String, completion: @escaping ([AssetHistory]?, String?) -> Void)
}

class AssetHistoriesWorker: AssetHistoriesWorkerProtocol {
    
    private var apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchAssetHistories(by id: String, completion: @escaping ([AssetHistory]?, String?) -> Void) {
        
        var parameters: [String: String] = [:]
        parameters["interval"] = "m5"
        parameters["start"] = "\(UInt(Date().timeIntervalSince1970 - 60*60*24) * 1000)"
        parameters["end"] = "\(UInt(Date().timeIntervalSince1970) * 1000)"
        
        self.apiService.getRequest(
            endPoint: "https://api.coincap.io/v2/assets/\(id)/history",
            parameters: parameters) { (response: DataResponse<AssetHistory>?, error: String?) in
            
            completion(response?.data, error)
        }
    }

}
