//
//  ViewController.swift
//  Matching
//
//  Created by Win Lwin on 24/08/2022.
//

import UIKit

class ViewController: UIViewController
{
	lazy var game : Matching = Matching(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
	
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var flipLabel: UILabel!
	@IBOutlet var cardButtons: [UIButton]!
	
	
	@IBAction func newGame() {
		//show all cards and faceDown
		emoji = [Int:String]()
		emojiChoice = themeForCards()
		
		for index in cardButtons.indices {
			let button = cardButtons[index]
			button.setTitle("", for: UIControl.State.normal)
			button.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
			
			for index in game.Cards.indices {
				game.Cards[index].isFaceUP = false
				game.Cards[index].isMatch = false
				
				game.flipCount = 0
				game.score = 0
				
				flipLabel.text = "Flips : \(game.flipCount)"
				scoreLabel.text = "Score : \(game.score)"
			}
		}
	}
	
	
	@IBAction func touchCard(_ sender: UIButton)
	{
		if let cardNumber = cardButtons.firstIndex(of: sender)
		{
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
			flipLabel.text = "Flips : \(game.flipCount)"
			scoreLabel.text = "Score : \(game.score)"
		}
	}
	
	func updateViewFromModel()
	{
		for index in cardButtons.indices
		{
			let button = cardButtons[index]
			let card = game.Cards[index]
			
			if card.isFaceUP
			{
				button.setTitle(emoji(for: card), for: UIControl.State.normal)
				button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			}
			else
			{
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = card.isMatch ? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0) : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
			}
		}
	}
	
	var emoji = [Int:String]()
	
	
	
	func themeForCards() -> [String] {
		let emojiTheme : [String : [String]]! =  ["Flags":["🇩🇪","🇯🇵","🇺🇸","🇲🇲","🇲🇾","🇨🇦","🇫🇷","🇦🇷","🇧🇷","🇮🇳"],
						  "Sports":["⚽️","🏀","🏈","🏑","🎾","🥊","🏉","🎱","🏓","🏏"],
						  "Fruits":["🍏","🍐","🍊","🍋","🍌","🍉","🍓","🥑","🍑","🍒"]]
		
		let keys = Array(emojiTheme.keys)
		let randomIndexForTheme = Int(arc4random_uniform(UInt32(keys.count)))
		let emojis = emojiTheme[keys[randomIndexForTheme]]!
		return emojis
	}
	
	lazy var emojiChoice = themeForCards()
	
	func emoji(for card: Card) -> String
	{
		if emoji[card.identity] == nil, emojiChoice.count > 0
		{
			let randomIndex = Int(arc4random_uniform(UInt32(emojiChoice.count)))
			
			emoji[card.identity] = emojiChoice.remove(at: randomIndex)
		}
		return emoji[card.identity] ?? "?"
	}
}

