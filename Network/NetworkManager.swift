//
//  NetworkManager.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 15.6.24..
//

import Foundation

class NetworkManager {
    private let defaultSession = URLSession(configuration: .default)
    static let shared = NetworkManager()
    private init() {}
    
    func fetchMetrics(completion: @escaping (Result<EthMetricsModel, Error>) -> Void) {
        // todo: put valid url here
        let urlString = "http://IP_ADDR_WITH_PORT/ENDPOINT"
          
          guard let url = URL(string: urlString) else {
              print("Invalid URL")
              return
          }
          
          let task = URLSession.shared.dataTask(with: url) { data, response, error in
              if let error = error {
                  completion(.failure(error))
                  return
              }
              
              guard let data = data else {
                  print("No data received")
                  return
              }
              
              do {
                  let decoder = JSONDecoder()
                  let ethMetrics = try decoder.decode(EthMetricsModel.self, from: data)
                  completion(.success(ethMetrics))
              } catch let decodeError {
                  completion(.failure(decodeError))
              }
          }
          
          task.resume()
    }
}
