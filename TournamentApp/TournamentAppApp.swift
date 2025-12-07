//
//  TournamentAppApp.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//
import SwiftUI

@main
struct TournamentAppApp: App {
    @AppStorage("appSessionID") var appSessionID: String = UUID().uuidString

    var body: some Scene {
        WindowGroup {
            ContentView()
                .id(appSessionID)
        }
    }
}
