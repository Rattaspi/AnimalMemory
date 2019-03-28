//
//  EasyScene.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 15/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

//protocol EasySceneDelegate : class {
//    func backToMainMenu(sender: EasyScene)
//}

class EasyScene : Scene {
    
    override func didMove(to view: SKView) {
        placeholderText = "EASY SCENE"
        
        //super.didMove(to: view)
        
        backButton?.delegate = self
        
        //Instantiate the gamelogic
        gamelogic = Gamelogic()
        gamelogic?.start(level: Gamelogic.Level.easy)
        
        //SETUP THE CARDSPRITES
        displayingCards = [CardSprite]()
        if let cards = gamelogic?.cards {
            for card in cards {
                let cardSprite = CardSprite(imageNamed: "animal_0")
                cardSprite.setUp(card: card, scene: self)
                displayingCards?.append(cardSprite)
            }
        }
        
        //Setup the cardsprite positions and
        //add those to the scene
        let initialPos = CGPoint(x: self.frame.width * 0.15, y: self.frame.height * 0.65)
        let offsetX = self.frame.width * 0.18
        let offsetY = self.frame.height * 0.18
        if let cards = displayingCards {
            for row in 0 ..< 2 {
                for column in 0 ..< 4 {
                    cards[row*4 + column].position = CGPoint(x: 100, y: 100)
                    cards[row*4+column].scale(to: CGSize(width: 512, height: 512))
                    
                }
            }
            for c in 0 ..< cards.count {
                addChild(cards[c])
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func onTap(sender: Button) {
        if(sender == backButton){
            changeSceneDelegate?.backToMainMenu(sender: self)
        }
    }
    
    
}
