//
//  LoginView.swift
//  A04
//
//  Created by user287050 on 11/22/25.
//
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            if let error = auth.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            if auth.isLoading {
                ProgressView()
            }
            
            HStack(spacing: 15) {
                Button("Sign In") {
                    auth.signIn(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || password.isEmpty)
                
                Button("Sign Up") {
                    auth.signUp(email: email, password: password)
                }
                .buttonStyle(.bordered)
                .disabled(email.isEmpty || password.isEmpty)
            }
            
            VStack(spacing: 5) {
                Text("Email is 123456@123456.com")
                    .font(.footnote)
                    .foregroundColor(.black)
                Text("Password is 123456")
                    .font(.footnote)
                    .foregroundColor(.black)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
