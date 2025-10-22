//
//  ContentView.swift
//  a01
//
//  Created by user287050 on 10/22/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View { ListEmoji() }
}

struct ListEmoji: View {
    @State private var counters: [Counter] = [
        .init(id: UUID(), count: 0, emoji: "😀"),
        .init(id: UUID(), count: 0, emoji: "🥳"),
        .init(id: UUID(), count: 0, emoji: "😎"),
        .init(id: UUID(), count: 0, emoji: "🤔"),
        .init(id: UUID(), count: 0, emoji: "😢"),
        .init(id: UUID(), count: 0, emoji: "😡")
    ]

    var body: some View {
        List {
            ForEach($counters) { $counter in
                CounterRow(counter: $counter)
                    .listRowBackground(Color.cyan)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.blue)
    }
}

struct CounterRow: View {
    let emojiSize: CGFloat = 50
    @Binding var counter: Counter

    var body: some View {
        HStack {
            Text(counter.emoji)
                .font(.system(size: emojiSize))
                .frame(width: 60, alignment: .leading)

            Spacer()

            Button {
                counter.decrement()
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: emojiSize / 2))
                    .foregroundColor(.black)
            }

            Text("\(counter.count)")
                .font(Font.system(size: emojiSize / 2))
                .monospacedDigit()
                .frame(width: 36)

            Button {
                counter.increment()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: emojiSize / 2))
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity,alignment: .center)
        .padding(.vertical, 10)
        .foregroundColor(.white)
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }	
}

struct Counter: Identifiable {
    var id: UUID
    var count: Int
    var emoji: String

    mutating func increment() { count += 1 }
    mutating func decrement() { if count > 0 { count -= 1 } }
}

#Preview { ContentView() }

