//
//  ContentView.swift
//  Memorize
//
//  Created by Xiang Yu Tuang on 14/9/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    var body: some View {
        ScrollView {
            Cards
            Spacer()
            Text("Current Theme: \(viewModel.chosenTheme.name)")
            Spacer()
            Button("New Game"){
                viewModel.newGame()
            }
            Spacer()
            Text("Score: \(viewModel.getScore())")
        }
        .foregroundColor(viewModel.chosenColor)
        .padding()
        
    }
    
    var Cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards){ card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
                }
        }
    }
}

struct CardView: View {
    let card: MemorizeGame<String>.Card
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched ? 0 : 1)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemorizeGame())
    }
}
