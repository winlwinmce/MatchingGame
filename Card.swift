//
//  Card.swift
//  Matching
//
//  Created by Win Lwin on 24/08/2022.
//

import Foundation

struct Card {
	var isFaceUP = false
	var isMatch = false
	
	var identity: Int
	
	
	static var uniqueIndentifier = 0
	static func getUniqueIdentifier() -> Int {
		uniqueIndentifier += 1
		return uniqueIndentifier
	}
	
	
	init() {
		self.identity = Card.getUniqueIdentifier()
	}
}
