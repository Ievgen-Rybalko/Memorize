//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ievgen Rybalko on 16.10.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndecies = cards.indices.filter({ cards[$0].isFaceUp})
            return faceUpCardIndecies.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (newValue == index)
//                if index != newValue {
//                    cards[index].isFaceUp = false
//                } else {
//                    cards[index].isFaceUp = true
//                }
            }
        }
    }

    mutating func choose(_ card: Card) {
        //if let chosenIndex = index(of: card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if (cards[chosenIndex].content == cards[potentialMatchIndex].content) {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true

            } else {
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        //print("chosenCard === \(chosenCard)")
    }

    func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }

    init(numberOfPairsOfCarrds: Int, createCardContent: (Int) -> CardContent) {
        cards = []  //Swift infer type  Array<Card>()
        // add numberOfPairsOfCarrds x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCarrds {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()

    }

    mutating func shaffle() {
        cards.shuffle()
    }

    struct Card: Identifiable {

        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
