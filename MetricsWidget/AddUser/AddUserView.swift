//
//  AddUserView.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 18.8.24..
//

import SwiftUI

struct AddUserView: View {
    @ObservedObject var viewModel = AddUserViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter username", text: $viewModel.username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Button(action: {
                viewModel.signUp()
            }) {
                Text("Submit")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(viewModel.isSuccessful ? "User Added" : "Error"),
                    message: Text(viewModel.isSuccessful ?
                                  "The user has been successfully added." : "Please, try again"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Add User")
    }
}
