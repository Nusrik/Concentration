//
//  Concentration.swift
//  Concentration
//
//  Created by Nusratillo on 22.02.2020.
//  Copyright © 2020 Nosirov's. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var score = 0
    var flipCount = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    var seenCards: Set<Int> = []
    
    struct point {
           static let bonus = 2
           static let penalty = 1
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if !cards[index].isFaceUp {
                flipCount += 1
            }
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += point.bonus
                } else {
                    if seenCards.contains(index) {
                        score -= point.penalty
                    }
                    if seenCards.contains(matchIndex) {
                        score -= point.penalty
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
//                 either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].isFaceUp = true
        }
    }
    
    func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
        score = 0
        flipCount = 0
        seenCards = []
        indexOfOneAndOnlyFaceUpCard = nil
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
