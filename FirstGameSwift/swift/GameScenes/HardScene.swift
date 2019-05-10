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
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        backButton?.delegate = self
        analytics.openSceneEvent(sceneName: "hard_scene")
        
        //Instantiate the gamelogic
        gamelogic = Gamelogic()
        gamelogic?.start(level: Gamelogic.Level.hard)
        gamelogic?.maxTime = 90
        
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
        let initialPos = CGPoint(x: self.frame.width * 0.15, y: self.frame.height * 0.12)
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
