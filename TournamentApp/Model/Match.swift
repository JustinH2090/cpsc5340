//
//  Match.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//

import Foundation

struct Match: Identifiable {
    let id = UUID()
    var player1: Player?
    var player2: Player?
    var winner: Player?
}
