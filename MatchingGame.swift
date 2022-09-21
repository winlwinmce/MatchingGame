//
//  MatchingGame.swift
//  Matching
//
//  Created by Win Lwin on 24/08/2022.
//

import Foundation

class Matching {
	var Cards = [Card]()
	
	var indexOfOneAndOlnyFaceUpCard : Int?
	
	var score = 0
	var flipCount = 0

	func chooseCard(at index: Int) {
		
		flipCount += 1
		
		if !Cards[index].isMatch
		{
			if let matchIndex = indexOfOneAndOlnyFaceUpCard, matchIndex != index
			{
				//check if matched
				if Cards[matchIndex].identity == Cards[index].identity
				{
					Cards[matchIndex].isMatch = true
					Cards[index].isMatch = true
					score += 2
				}
				else
				{
					score -= 1
				}

				Cards[index].isFaceUP = true
				indexOfOneAndOlnyFaceUpCard = nil
			}
			
			else
			{
				//either no cards or 2 cards
				for flipDownIndex in Cards.indices
				{
					Cards[flipDownIndex].isFaceUP = false
				}
				Cards[index].isFaceUP = true
				indexOfOneAndOlnyFaceUpCard = index
			}
		}
	}
	
	
	init(numberOfPairsOfCards : Int)
	{
		for _ in 0..<numberOfPairsOfCards
		{
			let card = Card()
			Cards += [card, card];
		}
		Cards = Cards.shuffled()
		
	}

}
