//
//  ContentView.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var showError = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.green.ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("My Tournament App")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.bottom, 100)

                    VStack(spacing: 20) {
                        TextField("Username", text: $username)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 12)
                            .background(Color.white)
                            .cornerRadius(8)
                            .font(.title2)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                        
                        SecureField("Password", text: $password)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 12)
                            .background(Color.white)
                            .cornerRadius(8)
                            .font(.title2)
                    }
                    .padding(.horizontal, 40)
                    VStack(spacing: 0) {
                        Text("Username - 1234")
                        Text("Password - 1234")
                    }
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)

                    
                    if showError {
                        VStack(spacing: 0) {
                            Text("Invalid username")
                            Text("or password")
                        }
                        .foregroundColor(.red)
                        .font(.system(size: 30))
                        .multilineTextAlignment(.center)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    
                    Button {
                        if username == "1234" && password == "1234" {
                            isAuthenticated = true
                            showError = false
                        } else {
                            showError = true
                        }
                    } label: {
                        Text("Continue")
                            .font(.system(size: 36, weight: .bold))
                            .padding(.horizontal, 40)
                            .padding(.vertical, 16)
                            
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationDestination(isPresented: $isAuthenticated){
                SetUpView()
            }
        }
    }
}

#Preview {
    ContentView()
}



