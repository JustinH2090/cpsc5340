//
// FavoritesView.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favorites: FavoritesViewModel
    private let bookManager = CategoryManager<BookModel>(storageKey: "favoriteBooks")

    private var fCities: [CityModel]  { favorites.cities.filter { $0.isFavorite } }
    private var fHobbies: [HobbyModel]{ favorites.hobbies.filter { $0.isFavorite } }
    private var fBooks: [BookModel]   { favorites.books.filter { $0.isFavorite } }

    var body: some View {
        NavigationStack {
            VStack {
                Text("Favorites")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)

                if fCities.isEmpty && fHobbies.isEmpty && fBooks.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "star")
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)
                        Text("No Favorites Selected")
                            .font(.title3).bold()
                            .padding(.horizontal, 32)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            if !fCities.isEmpty {
                                Text("Cities")
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 2)
                                VStack(spacing: 12) {
                                    ForEach(fCities) { city in
                                        CityCardView(city: city)
                                    }
                                }
                            }

                            if !fHobbies.isEmpty {
                                Text("Hobbies")
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 2)
                                VStack(spacing: 8) {
                                    ForEach(fHobbies) { hobby in
                                        HobbyRowView(hobby: hobby)
                                    }
                                }
                            }

                            if !fBooks.isEmpty {
                                Text("Books")
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 2)
                                VStack(spacing: 8) {
                                    ForEach(fBooks) { book in
                                        BookRowView(book: book)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}


