//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ievgen Rybalko on 14.10.2022.

//  LinearGradient(colors: [.red, .gray, .blue], startPoint: UnitPoint(x: 0, y: 0), endPoint:  UnitPoint(x: geometry.size.width, y: geometry.size.height))
//

import SwiftUI

struct EmojiMemoryGameView: View {

    @ObservedObject var gameViewModel: EmojiMemoryGame

    var body: some View {
            VStack {

                AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3, content: { card in
                    if card.isMatched && !card.isFaceUp {
                        Rectangle().opacity(0)
                    } else {
                    CardView(card)
                        .padding(4)
                        .onTapGesture {
                            gameViewModel.choose(card)
                        }
                    }
                })

//                ScrollView
//                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))])
//                    {
//                        ForEach(gameViewModel.cards) { card in

//                        }
//                    }
//                    .foregroundColor(.red)
//                }

//                Spacer()
//                HStack {
//                    addBtn
//                    Spacer()
//                    removeBtn
//                }
//                .font(.largeTitle)
//                .padding(.horizontal)
            }
            .padding(.horizontal)

        }

//    var removeBtn: some View {
//        Button {
//            if emojiCount > 1 {
//                emojiCount -= 1
//            }
//        } label:
//            { Image(systemName: "minus.circle") }
//    }
//
//    var addBtn: some View {
//        Button {
//            if emojiCount < emojis.count {
//                emojiCount += 1
//            }
//        } label:
//            { Image(systemName: "plus.circle") }
//    }
}

struct CardView: View {

    private let card: MemoryGame<String>.Card

    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }

    var body: some View {
        GeometryReader (content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)

                if card.isFaceUp {
                    shape
                        .fill(LinearGradient(colors: [.white, .white, .red, .white,.white,.white,.white, .white,.blue, .white, .white], startPoint: UnitPoint(x: 0, y: 0), endPoint:  UnitPoint(x: 1, y: 1)))
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Circle().fill(.red).padding(4).opacity(DrawingConstants.backgroundOpacity)
                    Text(card.content)
                        .font(cardFont(geometry.size))
                        .foregroundColor(.orange)
                } else if card.isMatched {
                    shape.opacity(0)
                    ZStack {
                        Circle().overlay(Text("Guessed").foregroundColor(.white), alignment: .center).opacity(0.5)
                    }
                    //Divider()

                } else {
                    shape
                        .fill(.red)
                }

            }
        })

    }

    private func cardFont(_ size: CGSize) -> Font {
        Font.system(size: DrawingConstants.fontScale * min (size.width, size.height))
    }

    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let backgroundOpacity: CGFloat = 0.5
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(gameViewModel: game)
            .preferredColorScheme(.dark)
//        EmojiMemoryGameView(gameViewModel: game)
//            .preferredColorScheme(.light)
    }
}


