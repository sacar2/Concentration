//
//  Concentration.swift
//  Concentration
//
//  Created by Selin Denise Acar on 2018-05-27.
//  Copyright © 2018 Selin Denise Acar. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard : Int?
    
    var score = 0
    
    var flipcount = 0
    
    func ChooseCard(at index : Int){
        //current card is not in a match
        if !cards[index].isMatched{
            //one card is already faced up and second selected card is not itself
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else{
                    if cards[index].hasBeenSeen == true{
                        score -= 1
                    }else{
                        cards[index].hasBeenSeen = true
                        }
                        
                    if cards[matchIndex].hasBeenSeen == true{
                        score -= 1
                    }else{
                        cards[matchIndex].hasBeenSeen = true
                        }
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                self.flipcount += 1
            }else{
                //No cards currently facing up, 2 cards are facing up, or second selected card is itself
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                if indexOfOneAndOnlyFaceUpCard == nil{
                    self.flipcount += 1
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func hideAllCardEmojis(){
        for index in cards.indices{
            if cards[index].isFacedUp {
                cards[index].isFacedUp = false
            }
        }
    }
    //initializes a randomized set of cards
    init(numberOfPairsOfCards: Int){
        Card.resetIdentifierFactory()
        hideAllCardEmojis()
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards.insert(card, at: Int(arc4random_uniform(UInt32(cards.count))))
            cards.insert(card, at: Int(arc4random_uniform(UInt32(cards.count))))
        }
    }
}
