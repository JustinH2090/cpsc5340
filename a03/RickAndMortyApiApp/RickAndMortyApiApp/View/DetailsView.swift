//
//  DetailsView.swift
//  RickAndMortyApiApp
//
//  Created by user287050 on 11/6/25.
//
import SwiftUI

struct DetailsView: View {
    let character: RickAndMortyCharacter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 25)

                AsyncImage(url: URL(string: character.image)) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Rectangle().fill(Color.gray.opacity(0.15))
                            ProgressView()
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .failure:
                        Color.gray
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    @unknown default:
                        EmptyView()
                    }
                }.padding(.top, 50)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 100) {
                    detailCell(title: "Status", value: character.status)
                    detailCell(title: "Species", value: character.species)
                    detailCell(title: "Gender", value: character.gender)
                    detailCell(title: "Episodes", value: "\(character.episode.count) total")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius:50))
                .padding(.top, 50)
            }
            .padding(.horizontal)
        }
    }

    @ViewBuilder
    private func detailCell(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    DetailsView(character: .init(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        gender: "Male",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2",
            "https://rickandmortyapi.com/api/episode/3"
        ]
    ))
}
