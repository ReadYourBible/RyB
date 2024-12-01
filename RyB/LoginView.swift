//
//  LoginView.swift
//  RyB
//
//  Created by VICTOR deMATOS on 01/12/24.
//


import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated: Bool = false

    var body: some View {
        if isAuthenticated {
            PreachingView()
        } else {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: authenticate) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Spacer()
            }
            .padding()
        }
    }

    func authenticate() {
        // Example authentication logic
        if email == "user@example.com" && password == "password" {
            isAuthenticated = true
        } else {
            print("Authentication failed")
        }
    }
}
