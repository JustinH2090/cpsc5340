//
//  ContentView.swift
//  RickAndMortyApiApp
//
//  Created by user287050 on 11/6/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ListVM()

    var body: some View {
        NavigationStack {
            ListView()
        }
        .environmentObject(vm)
    }
}

#Preview {
    ContentView()
        .environmentObject(ListVM())
}

