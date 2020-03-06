//
//  Card.swift
//  Concentration
//
//  Created by Nusratillo on 22.02.2020.
//  Copyright © 2020 Nosirov's. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
