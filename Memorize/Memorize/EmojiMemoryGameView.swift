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
                gameBody
                shaffle
            }
            .padding(.horizontal)
    }


        var gameBody: some View {
            AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Color.clear // Rectangle().opacity(0)
                } else {
                CardView(card)
                    .padding(4)
                    .transition(AnyTransition.scale.animation(Animation.easeInOut(duration: 0.6)))
                    // .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            gameViewModel.choose(card)
                        }
                    }
                }
            }
            .foregroundColor(.red)
        }

        var shaffle: some View {
            Button("Shaffle") {
                withAnimation(.easeInOut(duration: 0.6)) {
                    gameViewModel.shaffle()
                }
            }
        }
}

struct CardView: View {

    private let card: MemoryGame<String>.Card

    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }

    var body: some View {
        GeometryReader (content: { geometry in
            ZStack {

                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .fill(.red).padding(4).opacity(DrawingConstants.backgroundOpacity)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false))
                        .font(Font.system(size: DrawingConstants.fontSize))
                        .foregroundColor(.orange)
                        .scaleEffect(scale(thatFits: geometry.size))

            }
            .cardify(isFaceUp: card.isFaceUp)
        })

    }

    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }

    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let backgroundOpacity: CGFloat = 0.5
        static let fontSize: CGFloat = 32
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


