//
//  ContentView.swift
//  A04
//
//  Created by user287050 on 11/22/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        Group {
            if auth.user != nil {
                TBDView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}


