//
//  Model.swift
//  Set-Game
//
//  Created by Alexandra Harley on 7/16/23.
//

import Foundation

struct SetGameModel {
    // private(set): limit write access to within the scope of the struct but still allow the property to be read outside of the struct
    private(set) var dealingDeck: [Card] = []
    var discardDeck: [Card] = []
    
    init() {
        createDealingDeck()
    }
    
    mutating func createDealingDeck() {
        var count = 0
        var id = 0
        var numOfShapes = 1
        
        while (count <= 81) {
            let card = Card(id: id, numOfShapes: numOfShapes)
            dealingDeck.append(card)

            count += 1
            numOfShapes += 1
            id += 1
            if numOfShapes > 3 {
                numOfShapes = 1
            }
        }
    }
    
    func chooseCard(_ card: Card) {
        // if the card is not selected or matched, select the card
        
        // if the card is already selected, and less than three cards in the pile are currently selected, deselect the card
        
        // else if three cards are selected, compare them
            
        
    }
    
    func isSet() {
        // if set, move cards to discard Deck
        // if not a set, show error message
    }
    
    func gameOver() {
        // if dealing deck is 0 AND there are no more sets
            // end the game
    }
    
    
    // equatable: Types that conform to the Equatable protocol can be compared for equalit
    struct Card: Identifiable {
        var id: Int
        var numOfShapes: Int // At the core the number of shapes either have to be the same or different
        var isSelected = false
        var isMatched = false
        
        init(id: Int, numOfShapes: Int, isSelected: Bool = false, isMatched: Bool = false) {
            self.id = id
            self.numOfShapes = numOfShapes
        }
    }
}





