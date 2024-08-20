//
//  LoginViewModel.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 20.8.24..
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var username = ""
    @Published var navigateToNextScreen = false
    
    func signIn() {
        NetworkManager.shared.signIn(with: username) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.navigateToNextScreen = true
                    self?.showAlert = false
                    self?.username = ""
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self?.showAlert = true
                }
            }
        }
    }
}
