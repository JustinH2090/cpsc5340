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

    private let api = RickAndMortyAPI()

    func loadCharacters() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let result = try await api.fetchCharacters()
                DispatchQueue.main.async {
                    self.characters = result
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load characters."
                    self.isLoading = false
                }
            }
        }
    }
}

