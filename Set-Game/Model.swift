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
    // create an empty array that holds the ID for each chosen card
    var chosenCardIds: [Int] = []
    
    init() {
        createDealingDeck()
    }
    
    // use error type to determine error message (Maybe translate message in viewModel?
    enum ErrorType {
        case sameColor
        case sameShape
        case sameNumber
        case sameShading
    }
    
    // TODO: [REFACTOR] Break this down into smaller methods. See if logic can be simplified further.
    mutating func createDealingDeck() {
        var count = 1
        var id = 0
        
//        Maybe use as enum associated values and add the enum values to the numbers (?)
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
        
        dealingDeck.shuffle()
    }
    
    mutating func chooseCard(_ card: Card) {
//        unwrap if we have an index, card is not matched, and we have less than 3 cards chosen
        if let chosenIndex = dealingDeck.firstIndex(where: { $0.id == card.id}),
           !dealingDeck[chosenIndex].isMatched,
           dealingDeck.filter({ $0.isSelected == true }).count <= 2
        {

            // if the card is selected, unselect it
            if dealingDeck[chosenIndex].isSelected,
               dealingDeck.filter({ $0.isSelected == true }).count <= 2 {
                dealingDeck[chosenIndex].isSelected = false
                // remove the card from the chosen id deck
                chosenCardIds.removeAll(where: { $0 == dealingDeck[chosenIndex].id })
                //print("This card's ID (\(dealingDeck[chosenIndex].id)) has been removed.")
                return
            }
            
            // toggle the card to true
            dealingDeck[chosenIndex].isSelected.toggle()
            chosenCardIds.append(dealingDeck[chosenIndex].id)
            //print("This card's ID (\(dealingDeck[chosenIndex].id)) has been recorded.")
            
            // if the deck has three chosen cards, check if set
            if dealingDeck.filter({ $0.isSelected == true }).count == 3 {
                if isSet() {
                    isGameOver()
                } else {
                    
                }
                return
            }
            
            return
        }
    }
    
    // use a set - unique values and can count
    // TODO: Consider including error type in the return, turn into a tuple
    func isSet() -> Bool {
        // Confirm we have three cards before running this method
        guard dealingDeck.filter({ $0.isSelected == true }).count == 3,
              chosenCardIds.count == 3 else { return false }
        
        guard let card1 = dealingDeck.first(where: { $0.id == chosenCardIds[0] }),
                let card2 = dealingDeck.first(where: { $0.id == chosenCardIds[1] }),
                let card3 = dealingDeck.first(where: { $0.id == chosenCardIds[2] }) else { return false }
    
        // add all four features to sets. If we have a single count set and two 3 set count, then it is a match
        let featOneCount = Set([card1.content.color, card2.content.color, card3.content.color]).count
        let featTwoCount = Set([card1.content.number, card2.content.number, card3.content.number]).count
        let featThreeCount = Set([card1.content.shading, card2.content.shading, card3.content.shading]).count
        let featFourCount = Set([card1.content.shape, card2.content.shape, card3.content.shape]).count
        
        // if any sets have 2/3 cards, there are cards that share a feature (not a set)
        if featOneCount == 2 || featTwoCount == 2 || featThreeCount == 2 || featFourCount == 2 {
            return false
        }
        
        //TODO: put logic to check set here
        
        // Check valid Sets:
        // same number && same shape allowed (different shading, different color)
        
        // same shading && same shape allowed (different color, different number)
        
        // same shading (different color, number, shape)
        
        // same shape (different color, number, and shading)
    
        return false
     }
    
    func isGameOver() -> Bool {
        // if dealing deck is 0 OR dealing deck has less than two cards left
        if dealingDeck.count == 0 || dealingDeck.count < 3 {
            return true
        }
        
        return false
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





