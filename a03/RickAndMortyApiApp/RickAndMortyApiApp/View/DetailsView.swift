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
                    .padding(.top)
                AsyncImage(url: URL(string: character.image)) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Rectangle().fill(Color.gray.opacity(0.15))
                            ProgressView()
                        }
                        .frame(height: 260)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 260)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        Color.gray
                            .frame(height: 260)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    @unknown default:
                        EmptyView()
                    }
                }
                Group {
                    Text("Status")
                        .font(.headline)
                    Text(character.status)
                        .font(.subheadline)
                    Text("ID")
                        .font(.headline)
                        .padding(.top, 6)
                    Text("\(character.id)")
                        .font(.subheadline)
                    Text("Episodes")
                        .font(.headline)
                        .padding(.top, 6)
                    Text("\(character.episode.count) total")
                        .font(.subheadline)
                }
                if !character.episode.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(character.episode.prefix(6), id: \.self) { ep in
                                Text(ep.split(separator: "/").last.map(String.init) ?? "Ep")
                                    .font(.caption)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                            if character.episode.count > 6 {
                                Text("+\(character.episode.count - 6) more")
                                    .font(.caption)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DetailsView(character: .init(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2",
            "https://rickandmortyapi.com/api/episode/3"
        ]
    ))
}
