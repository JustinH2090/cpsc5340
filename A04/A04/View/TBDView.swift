//
//  TBDView.swift
//  A04
//
//  Created by user287050 on 11/22/25.
//
import SwiftUI

struct TBDView: View {
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("TBD")
                .font(.largeTitle)
            Spacer()
            Button("Log Out") {
                auth.signOut()
            }
            .buttonStyle(.bordered)
            .padding(.bottom, 40)
        }
        .padding()
    }
}
