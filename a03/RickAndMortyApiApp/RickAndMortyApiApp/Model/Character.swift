	//
//  Character.swift
//  RickAndMortyApiApp
//
//  Created by user287050 on 11/6/25.
//

import Foundation

struct CharacterResponse: Decodable {
    let results: [RickAndMortyCharacter]
}

struct RickAndMortyCharacter: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let status: String
    let image: String
    let episode: [String]
}
	
