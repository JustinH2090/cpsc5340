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
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(favorites.filteredCities(searchText: searchText)) { city in
                    CityCardView(city: city)
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
