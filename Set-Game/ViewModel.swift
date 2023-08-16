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
    var colors: [Color] = [.blue, .red, .yellow]
    var shapes: [AnyView] = [AnyView(Rectangle()), AnyView(Capsule()), AnyView(Diamond())]
    var shadings = [0.25, 0.6, 1]
    
    // model access vars
    var dealersDeck: [SetGameModel.Card] {
        model.dealingDeck
    }
    
    init() {
        self.model = SetGameModel()
    }
    
    func chooseCard(_ card: SetGameModel.Card) {
        model.chooseCard(card)
    }
    
    func newGame() {
        model = SetGameModel()
    }
    

    
    
    
}
