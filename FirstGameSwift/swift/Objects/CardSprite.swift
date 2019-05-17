//
//  CardSprite.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 21/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

protocol CardBehavior: class{
    func cardFlipped(card: CardSprite)
}

class CardSprite : Button {
    var card: Card?
    var frontTexture: SKTexture?
    var backTexture: SKTexture?
    var cardSize: CGSize?
    var cardDelegate: CardBehavior?
    
    var flipping = false
    
    func setUp(card: Card, scene: SKScene, size: CGSize, delegate: CardBehavior){
        self.card = card
        self.frontTexture = SKTexture(imageNamed: card.textF)
        self.backTexture = SKTexture(imageNamed: card.textB)
        self.cardSize = size
        self.cardDelegate = delegate
        
        super.clickSoundName = "sfx_flip3.wav"
        
        self.texture = backTexture
        self.isUserInteractionEnabled = true
        scale(to: size)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if(card?.state == Card.State.covered) {
            flip()
        }
    }
    
    func flip(){
        if(flipping){
           return
        }
        
        flipping = true
        let flipCard = SKAction.sequence([
            SKAction.scaleX(by: 0.001, y: 1, duration: 0.3),
            SKAction.run {
                if(self.card?.state == Card.State.covered){
                    self.texture = self.frontTexture
                    self.card?.state = Card.State.discovered
                }
                else {
                    self.texture = self.backTexture
                    self.card?.state = Card.State.covered
                }
            },
            SKAction.scaleX(by: 1/0.001, y: 1, duration: 0.3),
            SKAction.run {
                self.flipping = false
                if(self.card?.state == Card.State.discovered){
                    self.cardDelegate?.cardFlipped(card: self)
                }
            }
            ])
        
        run(flipCard)
    }
}
