//
//  ResultsView.swift
//  TournamentApp
//
//  Created by user287050 on 12/6/25.
//

import SwiftUI

struct ResultsView: View {
    let placements: [Player]
    @Environment(\.dismiss) var dismiss
    @AppStorage("appSessionID") var appSessionID: String = ""

    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Results")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.bottom, 10)
                
                List {
                    ForEach(Array(placements.enumerated()), id: \.1.id) { index, player in
                        HStack(alignment: .top, spacing: 16) {
                            Text("\(index + 1)")
                                .font(.title2)
                                .frame(width: 40, alignment: .leading)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(player.name)
                                    .font(.title2)
                                Text("Wins: \(player.wins)   Losses: \(player.losses)")
                                    .font(.body)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                
                Button {
                    appSessionID = UUID().uuidString
                } label: {
                    Text("Finish")
                        .font(.system(size: 40, weight: .bold))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    let players = [
        Player(name: "1st Place"),
        Player(name: "2nd Place"),
        Player(name: "3rd Place"),
        Player(name: "4th Place"),
        Player(name: "5th Place"),
        Player(name: "6th Place"),
        Player(name: "7th Place"),
        Player(name: "8th Place")
        ]
    ResultsView(placements: players)
}

