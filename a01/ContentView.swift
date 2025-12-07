//  ContentView.swift
//  a01
//
//  Created by user287050 on 10/22/25.

import SwiftUI

struct ContentView: View {
    var body: some View {ListEmoji()}
}

struct ListEmoji: View {
    @State private var emojiRow: [Emoji] = Emoji.makeEmojis()

    var body: some View {
        List {
            ForEach($emojiRow) { $counter in
                EmojiRow(emojiAndCounter: $counter)
                    .listRowBackground(Color.cyan)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.blue)
    }
}

struct EmojiRow: View {
    let SIZE: CGFloat = 50
    @Binding var emojiAndCounter: Emoji

    var body: some View {
        HStack {
            Text(emojiAndCounter.emoji)
                .font(.system(size: SIZE))
                .frame(width: 60, alignment: .leading)
            Spacer()
            Button {emojiAndCounter.decrement()} label: {
                Image(systemName: "minus")
                    .font(.system(size: SIZE / 2))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44, alignment: .center)
                    .contentShape(Rectangle())
            }
            Text("\(emojiAndCounter.count)")
                .font(.system(size: SIZE / 2))
                .monospacedDigit()
                .frame(width: 36)
            Button {emojiAndCounter.increment()} label: {
                Image(systemName: "plus")
                    .font(.system(size: SIZE / 2))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44, alignment: .center)
                    .contentShape(Rectangle())
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 10)
        .foregroundColor(.white)
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}

struct Emoji: Identifiable {
    let id = UUID()
    var count: Int
    var emoji: String

    init(count: Int = 0, emoji: String) {
        self.count = count
        self.emoji = emoji
    }

    static func makeEmojis() -> [Emoji] {
        [
            Emoji(emoji: "😀"),
            Emoji(emoji: "🥳"),
            Emoji(emoji: "😎"),
            Emoji(emoji: "🤔"),
            Emoji(emoji: "😢"),
            Emoji(emoji: "😡")
        ]
    }

    mutating func increment() {count += 1}
    mutating func decrement() {if count > 0 {count -= 1 }}
}

#Preview {ContentView()}
