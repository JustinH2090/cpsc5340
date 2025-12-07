//
//  SetUpViewModel.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//

import Foundation
import Combine
import SwiftUI

class SetUpViewModel: ObservableObject {
    @Published var playerName: String = ""
    @Published var players: [Player] = []
    
    func addPlayer() {
        let trimmed = playerName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        players.append(Player(name: trimmed))
        playerName = ""
    }
    
    func removePlayers(at offsets: IndexSet) {
        players.remove(atOffsets: offsets)
    }
    
    func buildTournament() -> Tournament {
        Tournament(
            name: "Tournament",
            dateCreated: Date(),
            players: players
        )
    }
}

