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
    
    // TODO: [REFACTOR] Break this down into smaller methods. See if logic can be simplified further.
    mutating func createDealingDeck() {
        var count = 0
        var id = 0
        
        var numOfShapes = 1
        var colorCount = 0
        var shapeCount = 0
        var shadingCount = 0
        
        while (count <= 81) {
            dealingDeck.append(Card(id: id, color: colorCount, number: numOfShapes, shape: shapeCount, shading: shadingCount))

            count += 1
            id += 1
            // shading count changes with each card
            shadingCount += 1
            
            // for every 27 cards, change the # of shapes
            if dealingDeck.count == 27 {
                numOfShapes = 2
            } else if dealingDeck.count == 54 {
                numOfShapes = 3
            }
            
            // for every three cards change the color
            if count % 3 == 0 {
                colorCount += 1
                if colorCount == 3 {
                    colorCount = 0
                }
            }
            
            // for every 9 cards, change shape
            if count % 9 == 0 {
                shapeCount += 1
                if shapeCount == 3 {
                    // once we've assigned the third shape, reset the count
                    shapeCount = 0
                }
            }
            
            // when we get to the third shading value, reset to 0
            if shadingCount > 2 {
                shadingCount = 0
            }
            
        }
    }
    
    mutating func chooseCard(_ card: Card) {
                // if the card is already selected, and less than three cards in the pile are currently selected, deselect the card
        if let chosenIndex = dealingDeck.firstIndex(where: { $0.id == card.id}),
           !dealingDeck[chosenIndex].isMatched {
            
            var card = dealingDeck[chosenIndex]
            print("\(card.isSelected)")
            card.isSelected.toggle()
            if dealingDeck.filter({ $0.isSelected == true }).count == 3 {
                isSet()
            }
            print("Is selected: \(card.isSelected), Total selected: \(dealingDeck.filter({ $0.isSelected == true }).count)")
        }
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
        let id: Int // does not change, unique ID for card to be identified when states change
        let content: CardFeatures
        var isSelected = false
        var isMatched = false
        
        init(id: Int, color: Int, number: Int, shape: Int, shading: Int) {
            self.id = id
            self.content = CardFeatures(color: color, number: number, shape: shape, shading: shading)
        }
    }
    
    struct CardFeatures {
        // all constants to prevent changing of card features
        let color: Int
        let number: Int
        let shape: Int
        let shading: Int
        
        init(color: Int, number: Int, shape: Int, shading: Int) {
            self.color = color
            self.number = number
            self.shape = shape
            self.shading = shading
        }
    }
}





