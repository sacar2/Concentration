//
//  ViewController.swift
//  Concentration
//
//  Created by Selin Denise Acar on 2018-05-09.
//  Copyright © 2018 Selin Denise Acar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //does not get set until it is needed
    private lazy var game : Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    //not setable because no setter has been set
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1)/2
    }
    
    //number of times the card is flipped
    private var flipcount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipcount)"
        }
    }
    
    private var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    private var emojiThemes = [["animals", "🦄","🙊","🐰", "🐙", "🐠", "🐩","🦋","🐧","🐸","🐷","🦊","🐳", "🦌", "🐥"],
                       ["food", "🥞","🍍","🥥", "🥒", "🥑", "🌮","🥗","🥙","🍲","🍜","🥟","🍨", "🍑", "🥖", "🌽", "🥘"],
                       ["buttons", "⏹","⏺","▶️", "⬆️", "↔️", "🆒","🔄","🔀","⏯","↕️","🔂","*️⃣", "🔼", "⏏️", "⏮"],
                       ["girly", "💇🏻‍♀️","💆🏼‍♀️","🧖🏾‍♀️", "💅🏿", "💄", "👑","💃🏾","🤳🏼","🍹","🍷","💐","💞"],
                       ["flags", "🏳️‍🌈","🇦🇿","🇦🇩", "🇨🇲", "🇰🇭", "🇭🇷","🇮🇳","🇸🇳","🇱🇨","🇼🇫","🇸🇹","🇰🇷", "🇻🇨", "🇸🇭", "🇵🇪"],
                       ["dayoff", "🚤","🏕","🏖", "🎡", "🛶", "👩🏻‍🎨","🛵","🤸🏻‍♀️","⛳️","🏂"," 🏈","💃🏾", "📷"],
                       ["moon","🌕","🌖","🌗", "🌘", "🌑", "🌒","🌓","🌔","🌝","🌛","🌜","🌚", "🌙"]
    ]
    
    private var colourThemes : [String : [UIColor]] = ["animals" : [UIColor.green, UIColor.white],
                                               "food" : [UIColor.brown, UIColor.white],
                                               "buttons" : [UIColor.white, UIColor.black],
                                               "girly": [UIColor.magenta, UIColor.black],
                                               "flags": [UIColor.black, UIColor.white],
                                               "dayoff": [UIColor.blue, UIColor.green],
                                               "moon": [UIColor.black, UIColor.purple]
    ]
    
    //A dictionary for the cards, linking the view(emojis) to the data model(Cards which have an identifier, matched bool value, and faced up bool value
    private var emoji = Dictionary<Int,String>()
    
    private lazy var emojiChoices = emojiThemes[emojiThemes.count.arc4random]
    
    private func resetEmojiChoices(){
        emojiChoices = emojiThemes[emojiThemes.count.arc4random]
        emoji = Dictionary<Int,String>()
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!

    //the label which displays the number of flips
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    
    //the cards on the UI
    @IBOutlet private var cardButtons: [UIButton]!
    
    //resets the data mmodel, restarts flip count, reset the emoji choices, reshuffles cards in the data source and view
    @IBAction private func newGame(_ sender: Any) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        flipcount = 0
        resetEmojiChoices()
        updateViewFromModel()
        updateBackgroundColour()
    }

    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.ChooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card is not in cardButtons")
         }
    }
    
    
    private func updateBackgroundColour(){
        view.backgroundColor = colourThemes[emojiChoices[0]]![0]
    }
    
    //updates the view according to the model if a card if selected
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            flipcount = game.flipcount
            score = game.score
            if card.isFacedUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.3546130359, green: 0.3546130359, blue: 0.3546130359, alpha: 0) : colourThemes[emojiChoices[0]]![1]
            }
        }
    }
    
    //selects an emoji from the choices of emojis to set the cards to
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: (emojiChoices.count-1).arc4random+1)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        updateBackgroundColour()
        updateViewFromModel()
    }
}


extension Int{
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
