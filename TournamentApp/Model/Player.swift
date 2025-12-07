//
//  Player.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//

import Foundation

struct Player: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var wins: Int = 0
    var losses: Int = 0
}

