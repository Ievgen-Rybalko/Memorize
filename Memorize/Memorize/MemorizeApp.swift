//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ievgen Rybalko on 14.10.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(gameViewModel: game)
        }
    }
}
