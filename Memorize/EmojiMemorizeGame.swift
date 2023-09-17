//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Xiang Yu Tuang on 15/9/23.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    
    
    private static var faces = ["😀","😭","🥵","😇","😍","🤓","🥶","🤯"]
    private static var vehicles =
        ["🚗", "🚒", "🛴", "🏍️", "🚡", "🚃", "✈️", "🛳️"]
    private static var animals =
        ["🐶", "🐱", "🐭", "🐰", "🐹", "🦊", "🐻", "🐼"]
    private static var halloween =
        ["👻","💀","👽","👾","🤖","🎃","👹", "🤡"]
    private static var food =
        ["🍏", "🥐", "🍗", "🍔", "🍣", "🍜", "🍰", "🍩"]
    static private let colors = ["gray", "red", "green", "blue", "orange"]
    
    static func getColor(_ color: String) -> Color {
        switch color {
        case "gray":
            return .gray
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "orange":
            return .orange
        default:
            return .orange
        }
    }
    
    static func createTheme(_ name: String, _ emojis: [String], _ numberOfPairs: Int) -> MemorizeGame<String>.Theme {
        let color = colors.randomElement()!
        return MemorizeGame<String>.Theme(name: name, emojis: emojis, numberOfPairs: numberOfPairs, cardColor: getColor(color))
    }
    
    static var themes: [MemorizeGame<String>.Theme] = {
        var themes = [MemorizeGame<String>.Theme]()
        themes.append(createTheme("faces", faces, 8))
        themes.append(createTheme("vehicles", vehicles, 8))
        themes.append(createTheme("halloween", halloween, 8))
        themes.append(createTheme("food", food, 8))
        themes.append(createTheme("animals", animals, 8))
        return themes
    }()
        
    
    
    
    static func createMemorizeGame(of chosenTheme: MemorizeGame<String>.Theme) -> MemorizeGame<String> {
        
        let numberOfPairsOfCards: Int = chosenTheme.numberOfPairs
        return MemorizeGame(numberOfPairsOfCards: numberOfPairsOfCards){ pairIndex in
            if chosenTheme.emojis.indices.contains(pairIndex){
                return chosenTheme.emojis[pairIndex]
            }
            else{
                return "??"
            }
        }
    }
    
    private(set) var chosenTheme: MemorizeGame<String>.Theme
    private(set) var chosenColor: Color
    @Published private var model: MemorizeGame<String>
    
    init() {
        chosenTheme = EmojiMemorizeGame.themes.randomElement()!
        chosenColor = chosenTheme.cardColor
        model = EmojiMemorizeGame.createMemorizeGame(of: chosenTheme)
    }
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    
    
    
    //MARK: INTENTS
    func choose(_ card: MemorizeGame<String>.Card){
        model.choose(card)
    }
        
    func shuffle(){
        model.shuffle()
    }
    
    func getScore() -> Int {
        model.score
    }
    
    func newGame(){
        chosenTheme = EmojiMemorizeGame.themes.randomElement()!
        chosenColor = chosenTheme.cardColor
        model = EmojiMemorizeGame.createMemorizeGame(of: chosenTheme)
    }
    
}
