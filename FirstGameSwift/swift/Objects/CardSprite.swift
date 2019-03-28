//
//  CardSprite.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 21/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

class CardSprite : Button {
    var card: Card?
    var frontTexture: SKTexture?
    var backTexture: SKTexture?
    
    func setUp(card: Card, scene: SKScene){
        self.card = card
        self.frontTexture = SKTexture(imageNamed: card.textF)
        self.backTexture = SKTexture(imageNamed: card.textB)
        
        self.texture = backTexture
    }
}
