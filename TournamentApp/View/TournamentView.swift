//
//  TournamentView.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//

import SwiftUI

struct TournamentView: View {
    @ObservedObject var viewModel: TournamentViewModel
    @State private var showResults = false
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            VStack(spacing: 20) {
                ScrollView {
                    VStack(spacing: 24) {
                        let roundIndex = viewModel.currentRoundIndex
                        ForEach(viewModel.rounds[roundIndex].indices, id: \.self) { matchIndex in
                            let match = viewModel.rounds[roundIndex][matchIndex]
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let p1 = match.player1 {
                                        Text(p1.name)
                                            .font(.body)
                                            .padding(6)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(
                                                match.winner?.id == p1.id
                                                ? Color.blue.opacity(0.8)
                                                : Color.white.opacity(0.8)
                                            )
                                            .foregroundColor(match.winner?.id == p1.id ? .white : .black)
                                            .cornerRadius(6)
                                            .onTapGesture {
                                                viewModel.selectWinner(p1,
                                                                       roundIndex: roundIndex,
                                                                       matchIndex: matchIndex)
                                            }
                                    }
                                    
                                    if let p2 = match.player2 {
                                        Text(p2.name)
                                            .font(.body)
                                            .padding(6)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(
                                                match.winner?.id == p2.id
                                                ? Color.blue.opacity(0.8)
                                                : Color.white.opacity(0.8)
                                            )
                                            .foregroundColor(match.winner?.id == p2.id ? .white : .black)
                                            .cornerRadius(6)
                                            .onTapGesture {
                                                viewModel.selectWinner(p2,
                                                                       roundIndex: roundIndex,
                                                                       matchIndex: matchIndex)
                                            }
                                    } else {
                                        Text("BYE")
                                            .font(.body)
                                            .padding(6)
                                    }
                                }
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color.white, lineWidth: 2)
                                        .frame(width: 120, height: 50)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white.opacity(0.2))
                                        )
                                    
                                    if let winner = match.winner {
                                        Text(winner.name)
                                            .font(.body)
                                    } else {
                                        Text("Click The Winner")
                                            .font(.system(size: 13))
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                if viewModel.hasNextRound {
                    Button("Next Round") {
                        viewModel.proceedToNextRound()
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.system(size: 30))
                    .disabled(!viewModel.canProceedToNextRound)
                    .padding(.bottom, 20)
                } else if viewModel.isCurrentRoundComplete {
                    Button("Finish Tournament") {
                        showResults = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 20)
                    .font(.system(size: 30))
                }
            }
        }
        .navigationDestination(isPresented: $showResults) {
            ResultsView(placements: viewModel.computePlacements())
        }
    }
}

#Preview {
    let players = [
        Player(name: "Player 1",wins: 0, losses: 0),
        Player(name: "Player 2",wins: 0, losses: 0),
        Player(name: "Player 3",wins: 0, losses: 0),
        Player(name: "Player 4",wins: 0, losses: 0),
        Player(name: "Player 5",wins: 0, losses: 0),
        Player(name: "Player 6",wins: 0, losses: 0),
        Player(name: "Player 7",wins: 0, losses: 0),
        Player(name: "Player 8",wins: 0, losses: 0),
        Player(name: "Player 9",wins: 0, losses: 0)
            ]
    let t = Tournament(name: "Tournament", dateCreated: Date(), players: players)
    TournamentView(viewModel: TournamentViewModel(tournament: t))
}
