//
//  ApiService.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import Alamofire

protocol ApiServiceProtocol {
    func getRequest<T: Decodable>(endPoint: String, parameters: [String: String], completion: @escaping (T?, String?) -> Void)
}

class ApiService: ApiServiceProtocol {

    func getRequest<T: Decodable>(endPoint: String, parameters: [String: String], completion: @escaping (T?, String?) -> Void) {
        
        AF
            .request(endPoint, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                print(response.data?.prettyPrintedJSONString ?? "")
                completion(response.value, response.error?.localizedDescription)
            }
    }
    

}
