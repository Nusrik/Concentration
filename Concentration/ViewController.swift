//
//  ViewController.swift
//  Concentration
//
//  Created by Nusratillo on 17.02.2020.
//  Copyright © 2020 Nosirov's. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
            return (cardButtons.count+1) / 2
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame() {
        game.resetGame()
        emojiChoices = emojiThemes.randomElement()!
        updateViewFromModel()
        emoji = [Int:String]()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
         }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "👹"]
    
    let emojiThemes = [
        /*"Halloween" : */["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "👹"],
        /*"Animals" : */["🐶", "🐭", "🦊", "🐯", "🐷", "🐸", "🐵", "🐔", "🦓", "🐧"],
        /*"Plants" : */["🌲", "🌳", "🌴", "🌾", "🌿", "🌷", "🌹", "🌸", "🌻", "🌼"],
        /*"Fruits" : */["🍏", "🍐", "🍊", "🍇", "🍉", "🍓", "🍒", "🍑", "🥑", "🍍"],
        /*"FastFood" : */["🍗", "🍖", "🌭", "🍔", "🍟", "🍕", "🌮", "🌯", "🍿", "🥤"],
        /*"Sports" : */["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏓", "🏸", "🏏", "⛸"]]
    
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
//        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
//            emoji[card.identifier] = emojiChoices.randomElement()
//        }
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

