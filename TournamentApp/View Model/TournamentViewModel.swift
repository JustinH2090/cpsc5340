//
//  TournamentViewModel.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//

import Foundation
import UniformTypeIdentifiers
import Combine	

import Foundation

class TournamentViewModel: ObservableObject {
    @Published var tournament: Tournament
    @Published var rounds: [[Match]]
    @Published var currentRoundIndex: Int = 0
    
    init(tournament: Tournament) {
        self.tournament = tournament
        self.rounds = [TournamentViewModel.makeRound(from: tournament.players)]
    }
    
    static func makeRound(from players: [Player]) -> [Match] {
        var result: [Match] = []
        var i = 0
        while i < players.count {
            let p1 = players[i]
            let p2 = i + 1 < players.count ? players[i + 1] : nil
            result.append(Match(player1: p1, player2: p2, winner: nil))
            i += 2
        }
        return result
    }
    
    var isCurrentRoundComplete: Bool {
        let matches = rounds[currentRoundIndex]
        for m in matches {
            if let _ = m.player1, m.player2 == nil {
                continue
            }
            if m.winner == nil {
                return false
            }
        }
        return true
    }
    
    private func nextPlayers(from roundIndex: Int) -> [Player] {
        let matches = rounds[roundIndex]
        var byePlayers: [Player] = []
        var winners: [Player] = []
        
        for m in matches {
            if let p1 = m.player1, m.player2 == nil {
                byePlayers.append(p1)
            } else if let w = m.winner {
                winners.append(w)
            }
        }
        
        return byePlayers + winners
    }
    
    var hasNextRound: Bool {
        nextPlayers(from: currentRoundIndex).count >= 2
    }
    
    var canProceedToNextRound: Bool {
        isCurrentRoundComplete && hasNextRound
    }
    
    func proceedToNextRound() {
        guard canProceedToNextRound else { return }
        
        let players = nextPlayers(from: currentRoundIndex)
        let nextRound = TournamentViewModel.makeRound(from: players)
        
        if currentRoundIndex + 1 < rounds.count {
            rounds[currentRoundIndex + 1] = nextRound
        } else {
            rounds.append(nextRound)
        }
        
        currentRoundIndex += 1
    }
    
    func selectWinner(_ player: Player, roundIndex: Int, matchIndex: Int) {
        var match = rounds[roundIndex][matchIndex]
        
        guard let p1 = match.player1, let p2 = match.player2 else {
            match.winner = player
            rounds[roundIndex][matchIndex] = match
            return
        }
        
        if let oldWinner = match.winner {
            let oldLoser = (oldWinner.id == p1.id) ? p2 : p1
            
            if let idx = tournament.players.firstIndex(where: { $0.id == oldWinner.id }) {
                tournament.players[idx].wins = max(0, tournament.players[idx].wins - 1)
            }
            if let idx = tournament.players.firstIndex(where: { $0.id == oldLoser.id }) {
                tournament.players[idx].losses = max(0, tournament.players[idx].losses - 1)
            }
        }
        
        match.winner = player
        rounds[roundIndex][matchIndex] = match
        
        let loser = (player.id == p1.id) ? p2 : p1
        
        if let idx = tournament.players.firstIndex(where: { $0.id == player.id }) {
            tournament.players[idx].wins += 1
        }
        if let idx = tournament.players.firstIndex(where: { $0.id == loser.id }) {
            tournament.players[idx].losses += 1
        }
    }

    
    func computePlacements() -> [Player] {
        var order: [UUID] = []
        
        if let final = rounds.last?.first, let champ = final.winner {
            order.append(champ.id)
        }
        
        var seen = Set<UUID>(order)
        
        if rounds.count > 0 {
            for roundIndex in stride(from: rounds.count - 1, through: 0, by: -1) {
                for match in rounds[roundIndex] {
                    guard let w = match.winner,
                          let p1 = match.player1,
                          let p2 = match.player2 else { continue }
                    let loser = p1.id == w.id ? p2 : p1
                    if !seen.contains(loser.id) {
                        order.append(loser.id)
                        seen.insert(loser.id)
                    }
                }
            }
        }
        
        for p in tournament.players {
            if !seen.contains(p.id) {
                order.append(p.id)
                seen.insert(p.id)
            }
        }
        
        return order.compactMap { id in
            tournament.players.first(where: { $0.id == id })
        }
    }
}

