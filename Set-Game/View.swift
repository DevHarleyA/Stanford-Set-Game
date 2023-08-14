//
//  ContentView.swift
//  Set-Game
//
//  Created by Alexandra Harley on 7/16/23.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.dealersDeck) { card in
                    CardView(game: game, card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.chooseCard(card)
                        }
                    
                }
            }
        }
    }
}

struct CardView: View {
    let game: SetViewModel
    let card: SetGameModel.Card
    var isSelected = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(.white)
            shape.strokeBorder(lineWidth: 2)
            shape.border(.green)
            // create the number of shapes for the card
            VStack {
                
                VStack {
                    ForEach(0..<card.content.number, id: \.self) { _ in
                        game.shapes[card.content.shape]
                            .foregroundColor(game.colors[card.content.color])
                            .frame(width: 20, height: 20)
                            .opacity(game.shadings[card.content.shading])
                            .border(game.colors[card.content.color])
                    }
                }
                
                Text("\(card.content.shading)")
            }
            .foregroundColor(.blue)
        }
    }
}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let testGame = SetViewModel()
        SetGameView(game: testGame)
            .preferredColorScheme(.dark)
    }
}
