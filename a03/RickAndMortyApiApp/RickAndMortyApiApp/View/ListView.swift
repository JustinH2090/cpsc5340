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
        ScrollView {
            if vm.isLoading {
                ProgressView("Loading Characters...")
                    .padding()
            } else if vm.characters.isEmpty {
                Text("No characters found.")
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(vm.characters) { character in
                        NavigationLink(destination: DetailsView(character: character)) {
                            VStack(alignment: .leading, spacing: 10) {
                                AsyncImage(url: URL(string: character.image)) { phase in
                                    switch phase {
                                    case .empty:
                                        ZStack {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(maxWidth: .infinity)
                                                .aspectRatio(1.1, contentMode: .fill)
                                            ProgressView()
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .frame(maxWidth: .infinity)
                                            .aspectRatio(1.1, contentMode: .fill)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    case .failure:
                                        Color.gray
                                            .frame(maxWidth: .infinity)
                                            .aspectRatio(1.1, contentMode: .fill)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(character.name)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.primary)
                                        .lineLimit(2)
                                    Text(character.status)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        }
                    }
                }
                .padding()
            }
        }
        .task {
            vm.loadCharacters()
        }
        .alert("Error", isPresented: Binding(
            get: { vm.errorMessage != nil },
            set: { _ in vm.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.errorMessage ?? "Unknown error")
        }
        .navigationTitle("Rick & Morty")
    }
}

#Preview {
    NavigationStack {
        ListView()
            .environmentObject(ListVM())
    }
}
