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
    var cardSize: CGSize?
    let flipCard = SKAction.sequence([
        SKAction.scaleX(by: 0.001, y: 1, duration: 0.3),
        SKAction.run {
            
        },
        SKAction.scaleX(by: 1/0.001, y: 1, duration: 0.3)
        ])
    
    func setUp(card: Card, scene: SKScene, size: CGSize){
        self.card = card
        self.frontTexture = SKTexture(imageNamed: card.textF)
        self.backTexture = SKTexture(imageNamed: card.textB)
        self.cardSize = size
        scale(to: size)
        
        self.texture = backTexture
        self.isUserInteractionEnabled = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        run(flipCard)
    }
}
