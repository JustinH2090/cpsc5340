//
//  ListVM.swift
//  RickAndMortyApiApp
//
//  Created by user287050 on 11/6/25.
//

import SwiftUI
import Combine

final class ListVM: ObservableObject {
    @Published var characters: [RickAndMortyCharacter] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let base = URL(string: "https://rickandmortyapi.com/api/character")!

    func loadCharacters() {
        guard !isLoading else {return}
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let result = try await fetchCharacters()
                await MainActor.run {
                    self.characters = result
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Failed to load characters."
                    self.isLoading = false
                }
            }
        }
    }

    private func fetchCharacters() async throws -> [RickAndMortyCharacter] {
        let (data, response) = try await URLSession.shared.data(from: base)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return decoded.results
    }
}


