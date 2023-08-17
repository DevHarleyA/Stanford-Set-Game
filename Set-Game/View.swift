//
//  ContentView.swift
//  Set-Game
//
//  Created by Alexandra Harley on 7/16/23.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetViewModel
    @State var prefix = 12
    
    var body: some View {
        NavigationView {
            ScrollView {
                newGameButton
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    // TODO: Adapt to Aspect VGrid
                    // TODO: Give only 12 cards initially. Change this number using an @State property
                    ForEach(game.dealersDeck.prefix(prefix)) { card in
                        CardView(game: game, card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.chooseCard(card)
                            }
                        
                    }
                }
                addThreeButton
            }
            .background(Color(CGColor(red: 254/255, green: 219/255, blue: 183/255, alpha: 1)))
            .navigationTitle("Set")
            
        }
        
//    TODO: Add game title
    }
    
    var addThreeButton: some View {
        Button("Add\nThree\nCards", action: addThree)
            .buttonStyle(.borderedProminent)
    }
    
    var newGameButton: some View {
        Button("New Game", action: {
            game.newGame()
            prefix = 12
        })
            .buttonStyle(.borderedProminent)
    }
    
    func addThree() {
        if game.dealersDeck.count >= 3 {
            prefix += 3
        } else if game.dealersDeck.isEmpty {
            return
        } else {
            prefix += game.dealersDeck.count
        }
    }
    // TODO: Create new game button
}

struct CardView: View {
    let game: SetViewModel
    let card: SetGameModel.Card
    var isSelected = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(.white)
            shape.strokeBorder(style: StrokeStyle.init(lineWidth: 3, dash: [5]))
            if card.isSelected {
                shape.fill().foregroundColor(.gray)
            }
            // create the number of shapes for the card
            VStack {
                
                VStack {
                    ForEach(0..<card.content.number, id: \.self) { _ in
                        game.shapes[card.content.shape]
                            .foregroundColor(game.colors[card.content.color])
                            .frame(width: 25, height: 25)
                            .opacity(game.shadings[card.content.shading])
                    }
                }
                .padding(.horizontal)
    
            }
        }
    }
    
    // TODO: function that checks the card.content.number and returns a frame height and size
}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let testGame = SetViewModel()
        SetGameView(game: testGame)
//            .preferredColorScheme(.light)
    }
}
