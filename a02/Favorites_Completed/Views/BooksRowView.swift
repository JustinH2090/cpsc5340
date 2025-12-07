//
//  BooksRowView.swift
//  Favorites_Completed
//
//  Created by user287050 on 11/1/25.
//

import SwiftUI

struct BookRowView: View {
    let book: BookModel
    @EnvironmentObject private var favorites: FavoritesViewModel
    private let bookManager = CategoryManager<BookModel>(storageKey: "favoriteBooks")
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(book.bookTitle)
                    .font(.headline)
                Text(book.bookAuthor)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            Button {
                var items = favorites.books
                bookManager.toggleFavorite(items: &items, targetItem: book)
                favorites.books = items
            } label: {
                Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(book.isFavorite ? .red : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    BookRowView(book: BookModel(id: 1, bookTitle: "The Hobbit", bookAuthor: "J.R.R. Tolkien"))
        .environmentObject(FavoritesViewModel())
}
