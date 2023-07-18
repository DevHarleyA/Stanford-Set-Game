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
                    CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                    
                }
            }
        }
    }
}

struct CardView: View {
    let card: SetGameModel.Card
    var isSelected = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
                shape.fill().foregroundColor(.green)
                shape.strokeBorder(lineWidth: 2)
            Text("\(card.numOfShapes)")
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
