//
//  AddUserViewModel.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 18.8.24..
//

import Foundation


class AddUserViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var username: String = ""
    @Published var isSuccessful = false
    
    func signUp() {
        NetworkManager.shared.signUp(with: username) { [weak self] result in
            DispatchQueue.main.async {
                self?.showAlert = true
                switch result {
                case .success(let data):
                    print("Data received: \(data)")
                    self?.isSuccessful = true
                    self?.username = ""
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self?.isSuccessful = false
                }
            }
        }
    }
}
