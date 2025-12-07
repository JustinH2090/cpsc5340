//
//  SetUptView.swift
//  TournamentApp
//
//  Created by user287050 on 12/5/25.
//

import SwiftUI

struct SetUpView: View {
    @StateObject private var viewModel = SetUpViewModel()
    @State private var isOn = false
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Color.clear.frame(height: 40)
                Text("\tEnter Player Names\t")
                    .font(.largeTitle)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .padding(.top, 40)

                HStack {
                    Toggle("Double Elimination\t\t\t\t", isOn: $isOn)
                        .font(.title2)
                }
                .fixedSize()
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(10)

                HStack {
                    TextField("Player Name", text: $viewModel.playerName)
                        .padding(.vertical, 30)
                            .padding(.horizontal, 10)
                            .background(Color.white)
                            .cornerRadius(8)
                    
                    Button("Add") {
                        viewModel.addPlayer()
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.title)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                List {
                    ForEach(viewModel.players) { player in
                        Text(player.name)
                    }
                    .onDelete(perform: viewModel.removePlayers)
                }
                .scrollContentBackground(.hidden)
                
                if !viewModel.players.isEmpty {
                    NavigationLink {
                        let t = viewModel.buildTournament()
                        TournamentView(viewModel: TournamentViewModel(tournament: t))
                    } label: {
                        Text("Start Tournament")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SetUpView()
    }
}
