//
//  ViewModel.swift
//  Set-Game
//
//  Created by Alexandra Harley on 7/16/23.
//

import SwiftUI

// ObservableObject: Notates an object with a publisher that emits before the object has changed (tells the view the model has changed!)
class SetViewModel: ObservableObject {
    @Published private var model: SetGameModel
    var dealersDeck: [SetGameModel.Card] {
        model.dealingDeck
    }
    
    init() {
        self.model = SetGameModel()
    }
    
    func newGame() {
        // function to create a new game
    }
    
    struct Theme {
        var color: UIColor
        var shape: String
        var shading: Double // Opacity 0 invis - 1 opaque
        
        init(color: UIColor, shape: String, shading: Double) {
            self.color = color
            self.shape = shape
            self.shading = shading
        }
    }
    
}
