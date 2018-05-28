//
//  Card.swift
//  Concentration
//  This is UI independent!!!! this is just how the card behaves, how the game works...
//  Created by Selin Denise Acar on 2018-05-27.
//  Copyright © 2018 Selin Denise Acar. All rights reserved.
//

import Foundation

struct Card{
    var isMatched = false
    var isFacedUp = false
    var identifier: Int
    var hasBeenSeen = false
    
    static var identifierFactory: Int = 0
    
    static func resetIdentifierFactory() {
        identifierFactory = 0
    }
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
