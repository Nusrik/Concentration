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
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var flipCount = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private var seenCards: Set<Int> = []
    
    private struct point {
           static let bonus = 2
           static let penalty = 1
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
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
                cards[index].isFaceUp = true
            } else {
//                 either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
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
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
