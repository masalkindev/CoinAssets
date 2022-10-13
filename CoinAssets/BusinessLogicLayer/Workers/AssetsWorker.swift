//
//  AssetsWorker.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Foundation

protocol AssetsWorkerProtocol {
    func fetchAssets(by page: Int, query: String?, completion: @escaping ([Asset]?, String?) -> Void)
}

class AssetsWorker: AssetsWorkerProtocol {
    
    private var apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    /// page numiration beginning with 1, 2, 3, etc
    func fetchAssets(by page: Int, query: String?, completion: @escaping ([Asset]?, String?) -> Void) {
        
        let limit = 10
        let offset = (page - 1) * limit
        
        var parameters: [String: String] = [:]
        parameters["limit"] = "\(limit)"
        parameters["offset"] = "\(offset)"
        if let query = query, query.count > 0 {
            parameters["search"] = query
        }
        
        self.apiService.getRequest(
            endPoint: "https://api.coincap.io/v2/assets",
            parameters: parameters) { (response: DataResponse<Asset>?, error: String?) in
            completion(response?.data, error)
        }
        
    }

}
