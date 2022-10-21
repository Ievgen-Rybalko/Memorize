//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ievgen Rybalko on 16.10.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    typealias Card = MemoryGame<String>.Card

    private static let emojis = ["✈️","🚘","🚜","🚂","🚛","🚑","🚃","🚁","🛸","🚕","🚌","🚎","🛻","🛵","🏎","🚠","🛴","🚲","🏍","🛺","🚡","🚋","🚀","⛵️"]

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCarrds: 6) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }

    @Published private(set) var model = createMemoryGame()


    var cards: Array<Card> {
        return model.cards
    }

    // MARK: - Intent(s)

    func choose(_ card: Card) {
        //objectWillChange.send()
        model.choose(card)
    }
}
