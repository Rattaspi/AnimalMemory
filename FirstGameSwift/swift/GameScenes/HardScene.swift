//
//  HardScene.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 15/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

//protocol HardSceneDelegate : class {
//    func backToMainMenu(sender: HardScene)
//}

class HardScene : Scene {
    //weak var changeSceneDelegate : HardSceneDelegate?
    //private var displayingCards: [CardSprite]?
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        backButton?.delegate = self
        
        //Instantiate the gamelogic
        gamelogic = Gamelogic()
        gamelogic?.start(level: Gamelogic.Level.hard)
        
        //SETUP THE CARDSPRITES
        displayingCards = [CardSprite]()
        if let cards = gamelogic?.cards {
            for card in cards {
                let cardSprite = CardSprite(imageNamed: "")
                if let gamelogic = gamelogic {
                    cardSprite.setUp(card: card, scene: self, size: CGSize(width: 60, height: 72), delegate: gamelogic)
                    displayingCards?.append(cardSprite)
                }
            }
        }
        
        //Setup the cardsprite positions and
        //add those to the scene
        let initialPos = CGPoint(x: self.frame.width * 0.145, y: self.frame.height * 0.12)
        let offsetX = self.frame.width * 0.168
        let offsetY = self.frame.height * 0.14
        if let cards = displayingCards {
            let cardShuffled = cards.shuffled()
            for row in 0 ..< 6 {
                for column in 0 ..< 5 {
                    let i = row * 5 + column
                    let x = initialPos.x + offsetX * CGFloat(column)
                    let y = initialPos.y + offsetY * CGFloat(row)
                    cardShuffled[i].position = CGPoint(x: x, y: y)
                }
            }
            for c in 0 ..< cardShuffled.count {
                addChild(cardShuffled[c])
            }
        }
    }
    
    override func onTap(sender: Button) {
        if(sender == backButton){
            changeSceneDelegate?.backToMainMenu(sender: self)
        }
    }
}
