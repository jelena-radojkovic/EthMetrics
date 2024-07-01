//
//  NetworkManager.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 15.6.24..
//

import Foundation
//import Alamofire

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    func fetchMetrics(completion: @escaping (EthMetricsModel) -> Void) {
        // TODO: change the url for AF.request
//        AF.request("http://127.0.0.1:5000/metrics")
//            .responseDecodable { (response: DataResponse<EthMetricsModel, AFError>) in
//                guard response.error != nil else {
//                    print("🥶 Error on fetching metrics: \(String(describing: response.error))")
//                    return
//                }
//                
//                do {
//                    try completion(response.result.get())
//                } catch {
//                    print("🥶 Error on parsing metrics: \(String(describing: error.localizedDescription))")
//                }
//            }
    }
}
