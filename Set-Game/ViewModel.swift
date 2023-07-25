//
//  ViewModel.swift
//  Set-Game
//
//  Created by Alexandra Harley on 7/16/23.
//

import SwiftUI

// ObservableObject: Notates an object with a publisher that emits before the object has changed (tells the view the model has changed!)
class SetViewModel: ObservableObject {
    // model
    @Published private var model: SetGameModel
    
    // additional vars
    var colors: [Color] = [.orange, .red, .green]
    var shapes: [AnyView] = [AnyView(Rectangle()), AnyView(Capsule()), AnyView(Diamond())]
    var shadings = [0.0, 0.5, 1]
    
    // model access vars
    var dealersDeck: [SetGameModel.Card] {
        model.dealingDeck
    }
    
    init() {
        self.model = SetGameModel()
    }
    
//    func newGame() {
//        // create game
//        let game = SetGameModel()
//        // create CardContent for each card
//        createThemes()
//        // provide each card it's content
//        _ = game.dealingDeck.map { card in
//            for theme in contentArray {
//                var newCard = card
//                newCard.content = theme
////                dealersDeck.append(newCard)
//            }
//        }
//    }
    

    
    
    
}
