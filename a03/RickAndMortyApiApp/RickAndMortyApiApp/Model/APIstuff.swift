//
//  APIstuff.swift
//  RickAndMortyApiApp
//
//  Created by user287050 on 11/6/25.
//
import Foundation

final class RickAndMortyAPI {
    private let base = URL(string: "https://rickandmortyapi.com/api/character")!

    func fetchCharacters() async throws -> [RickAndMortyCharacter] {
        let (data, response) = try await URLSession.shared.data(from: base)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return decoded.results
    }
}
