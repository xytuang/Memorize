//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Xiang Yu Tuang on 14/9/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemorizeGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EmojiMemorizeGame())
        }
    }
}
