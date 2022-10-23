//
//  Cardify.swift
//  Memorize
//
//  Created by Ievgen Rybalko on 21.10.2022.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    var rotation: Double // in degrees

    func body(content: Content) -> some View {
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)

            if rotation < 90 {
                shape
                    .fill(LinearGradient(colors: [.white, .white, .red, .white,.white,.white,.white, .white,.blue, .white, .white], startPoint: UnitPoint(x: 0, y: 0), endPoint:  UnitPoint(x: 1, y: 1)))
                shape
                    .strokeBorder(lineWidth: DrawingConstants.lineWidth)

//                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
//                    .fill(.red).padding(4).opacity(DrawingConstants.backgroundOpacity)
//                Text(card.content)
//                    .font(cardFont(geometry.size))
//                    .foregroundColor(.orange)
//            } else if card.isMatched {
//                shape.opacity(0)
//                ZStack {
//                    Circle().overlay(Text("Guessed").foregroundColor(.white), alignment: .center).opacity(0.5)
//                }
                //Divider()

            } else {
                shape
                    .fill(.red)
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}

private struct DrawingConstants {
    static let cornerRadius: CGFloat = 15
    static let lineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
