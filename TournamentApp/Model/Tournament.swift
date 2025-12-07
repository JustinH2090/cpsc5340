//
//  Tournament.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//
import Foundation

struct Tournament: Identifiable {
    let id = UUID()
    let name: String
    let dateCreated: Date
    var players: [Player]
}
