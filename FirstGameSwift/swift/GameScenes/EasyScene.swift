//
//  EasyScene.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 15/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

class EasyScene : Scene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backButton?.delegate = self
        
        analytics.openSceneEvent(sceneName: "easy_scene")
        
        //Instantiate the gamelogic
        gamelogic = Gamelogic()
        gamelogic?.start(level: Gamelogic.Level.easy)
        gamelogic?.maxTime = 20
        
        //SETUP THE CARDSPRITES
        displayingCards = [CardSprite]()
        if let cards = gamelogic?.cards {
            for card in cards {
                let cardSprite = CardSprite(imageNamed: "")
                if let gamelogic = gamelogic {
                    cardSprite.setUp(card: card, scene: self, size: CGSize(width: 70, height: 84), delegate: gamelogic)
                    displayingCards?.append(cardSprite)
                }
            }
        }
    
        //Setup the cardsprite positions and
        //add those to the scene
        let initialPos = CGPoint(x: self.frame.width * 0.20, y: self.frame.height * 0.4)
        let offsetX = self.frame.width * 0.2
        let offsetY = self.frame.height * 0.16
        if let cards = displayingCards {
            let cardShuffled = cards.shuffled()
            for row in 0 ..< 2 {
                for column in 0 ..< 4 {
                    let i = row * 4 + column
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
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    override func onTap(sender: Button) {
        if(sender == backButton){
            errorPrevention()
        }
    }
    
    func backToMainMenu(){
        changeSceneDelegate?.backToMainMenu(sender: self)
    }
    
    func errorPrevention(){
        let popup = UIAlertController(title: NSLocalizedString("Error title", comment: ""), message: NSLocalizedString("Error message", comment: ""), preferredStyle: UIAlertController.Style.alert)
        
        popup.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            self.analytics.gameCancelled(time: self.gamelogic?.bonusTime ?? 0)
            self.backToMainMenu()
        }))
        
        popup.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        vc.present(popup, animated: true, completion: nil)
    }
    
}
