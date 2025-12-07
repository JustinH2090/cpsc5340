//
//  ListView.swift
//  RickAndMortyApiApp
//
//  Created by user287050 on 11/6/25.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var vm: ListVM
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView(.vertical) {
            if vm.isLoading {
                ProgressView("Loading")
                    .padding()
            } else if vm.characters.isEmpty {
                Text("No characters found.")
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(vm.characters) { character in
                        NavigationLink {
                            DetailsView(character: character)
                        } label: {
                            VStack(spacing: 10) {
                                Text(character.name)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity)

                                Text(character.status)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 125)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .task {
            vm.loadCharacters()
        }
        .alert("Error", isPresented: Binding(
            get: {vm.errorMessage != nil},
            set: {_ in vm.errorMessage = nil}
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.errorMessage ?? "Unknown error")
        }
    }
}

#Preview {
    NavigationStack {
        ListView()
            .environmentObject(ListVM())
    }
}
