//
//  BooksView.swift
//  Favorites_Completed
//
//  Created by user287050 on 11/1/25.
//

import SwiftUI

struct BooksView: View {
    @EnvironmentObject var favorites: FavoritesViewModel
    @Binding var searchText: String
	
    private let bookManager = CategoryManager<BookModel>(storageKey: "favoriteBooks")

    private var filtered: [BookModel] {
        bookManager.filteredItems(items: favorites.books, searchText: searchText)
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(filtered) { book in
                    BookRowView(book: book)
                }
            }
            .padding()
        }
    }
}

#Preview {
    BooksView(searchText: .constant(""))
        .environmentObject(FavoritesViewModel())
}

