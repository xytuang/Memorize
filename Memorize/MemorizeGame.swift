//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Xiang Yu Tuang on 15/9/23.
//

import Foundation
import SwiftUI

struct MemorizeGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: "\(index)a", content: content))
            cards.append(Card(id: "\(index)b", content: content))
        }
        cards.shuffle()
    }
    
    var score: Int = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {cards.indices.filter {index in cards[index].isFaceUp}.only}
        set {cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)}}
    }

    mutating func choose(_ card: Card){
        if let foundIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[foundIndex].isFaceUp && !cards[foundIndex].isMatched{
                if let potentialMatch = indexOfOneAndOnlyFaceUpCard {
                    if cards[foundIndex].content == cards[potentialMatch].content{
                        cards[foundIndex].isMatched = true
                        cards[potentialMatch].isMatched = true
                        score += 2
                    }
                    else {
                        score -= 1
                    }
                }
                else{
                    indexOfOneAndOnlyFaceUpCard = foundIndex
                }
                cards[foundIndex].isFaceUp = true
            }
        }
    }
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: String
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
    
    struct Theme {
        let name: String
        let emojis: [String]
        var numberOfPairs: Int
        let cardColor: Color
    }
}

extension Array {
    var only: Element? {count == 1 ? first : nil}
}
