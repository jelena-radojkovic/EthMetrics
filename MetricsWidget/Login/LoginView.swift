//
//  LoginView.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 18.8.24..
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter your username", text: $viewModel.username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                viewModel.signIn()
            }) {
                Text("Login")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text("Please try again"),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            NavigationLink(
                destination: HomeView(),
                isActive: $viewModel.navigateToNextScreen,
                label: {
                    EmptyView()
                }
            )
        }
        .padding()
    }
}
