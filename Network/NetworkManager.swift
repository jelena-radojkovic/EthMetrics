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
    private var sessionToken: String?
    private init() {}
    
    func signUp(with username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "http://IP_ADDR_WITH_PORT/ENDPOINT"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userRequest = UserRequest(username: username)
        
        do {
            let jsonData = try JSONEncoder().encode(userRequest)
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
    
    func signIn(with username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "http://IP_ADDR_WITH_PORT/ENDPOINT"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userRequest = UserRequest(username: username)
        
        do {
            let jsonData = try JSONEncoder().encode(userRequest)
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                let response = try decoder.decode(LoginResponse.self, from: data)
                NetworkManager.shared.sessionToken = response.token
                completion(.success(()))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        }
        
        task.resume()
    }
    
    func fetchMetrics(completion: @escaping (Result<EthMetricsModel, Error>) -> Void) {
        guard let sessionToken = NetworkManager.shared.sessionToken else {
            completion(.failure(NSError()))
            return
        }
        
        let urlString = "http://IP_ADDR_WITH_PORT/ENDPOINT"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(sessionToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
