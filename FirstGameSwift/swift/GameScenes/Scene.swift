//
//  GameScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 21/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import UIKit
import SpriteKit

protocol SceneDelegate: class {
    func backToMainMenu(sender: SKScene)
    func goToGameOver(sender: SKScene, gamelogic: Gamelogic, level: String)
}

class Scene: SKScene, ButtonDelegate {
    weak var changeSceneDelegate : SceneDelegate?
    weak var gameoverDelegate: SceneDelegate?
    var vc: UIViewController!
    
    let analytics = AnalyticsManager()

    var info: GameInfo!
    var level: Gamelogic.Level!
    
    var displayingCards: [CardSprite]?
    var gamelogic: Gamelogic?
    var backButton: Button?
    
    //Score setup properties
    var scoreIcon: SKSpriteNode?
    var scoreLabel: SKLabelNode?
    var bonusIcon: SKSpriteNode?
    var bonusLabel: SKLabelNode?
    
    //Some scene setup info
    let scoreFontSize: CGFloat = 23
    
    override func didMove(to view: SKView) {        
        
        
        //BACKGROUND
        Common.setupBackground(scene: self, imageNamed: GameInfo.bgName)
        
        //back button
        backButton = Button(imageNamed: "back_arrow")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.1, y: self.frame.height * 0.95)
            backButton.scaleAspectRatio(width: self.frame.width * 0.1)
            backButton.isUserInteractionEnabled = true
            backButton.delegate = self
            
            addChild(backButton)
        }
        
        //***SCORE***
        //score icon
        scoreIcon = SKSpriteNode(imageNamed: "score")
        if let scoreIcon = scoreIcon {
            scoreIcon.position = CGPoint(x: self.frame.width * 0.35, y: self.frame.height * 0.93)
            scoreIcon.scale(to: CGSize(width: self.frame.width * 0.12, height: self.frame.width * 0.12))
            
            addChild(scoreIcon)
        }
        //score label
        scoreLabel = SKLabelNode(text: "0")
        if let scoreLabel = scoreLabel {
            scoreLabel.position = CGPoint(x: self.frame.width * 0.43, y: self.frame.height * 0.92)
            scoreLabel.verticalAlignmentMode = .center
            scoreLabel.horizontalAlignmentMode = .left
            scoreLabel.fontSize = scoreFontSize
            
            addChild(scoreLabel)
        }
        
        //***BONUS***
        //bonus icon
        bonusIcon = SKSpriteNode(imageNamed: "bonus")
        if let bonusIcon = bonusIcon{
            bonusIcon.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.height * 0.92)
            bonusIcon.scale(to: CGSize(width: self.frame.width * 0.12, height: self.frame.width * 0.12))
            addChild(bonusIcon)
        }
        //bonus label
        bonusLabel = SKLabelNode(text: "999")
        if let bonusLabel = bonusLabel {
            bonusLabel.position = CGPoint(x: self.frame.width * 0.82, y: self.frame.height * 0.92)
            bonusLabel.verticalAlignmentMode = .center
            bonusLabel.horizontalAlignmentMode = .left
            bonusLabel.fontSize = scoreFontSize
            
            addChild(bonusLabel)
        }
        
        //Instantiate the gamelogic
        gamelogic = Gamelogic()
        
        
        //***SETUP THE CARDS DEPENDING ON THE LEVEL***
        switch level! {
        case Gamelogic.Level.easy:
            analytics.openSceneEvent(sceneName: "easy_scene")
            gamelogic?.start(level: Gamelogic.Level.easy)
            gamelogic?.maxTime = 20
            info = Easy()
            
        case Gamelogic.Level.medium:
            analytics.openSceneEvent(sceneName: "medium_scene")
            gamelogic?.start(level: Gamelogic.Level.medium)
            gamelogic?.maxTime = 60
            info = Medium()
            
        case Gamelogic.Level.hard:
            analytics.openSceneEvent(sceneName: "hard_scene")
            gamelogic?.start(level: Gamelogic.Level.hard)
            gamelogic?.maxTime = 90
            info = Hard()
        }
        
        //SETUP THE CARDSPRITES
        displayingCards = [CardSprite]()
        if let cards = gamelogic?.cards {
            for card in cards {
                let cardSprite = CardSprite(imageNamed: "")
                if let gamelogic = gamelogic {
                    cardSprite.setUp(card: card, scene: self, size: CGSize(width: info.cWidth, height: info.cHeight), delegate: gamelogic)
                    displayingCards?.append(cardSprite)
                }
            }
        }
        
        //Setup the cardsprite positions and
        //add those to the scene
        let initialPos = CGPoint(x: self.frame.width * info.initialPos.x, y: self.frame.height * info.initialPos.y)
        let offsetX = self.frame.width * info.offset.x
        let offsetY = self.frame.height * info.offset.y
        if let cards = displayingCards {
            let cardShuffled = cards.shuffled()
            for row in 0 ..< info.row {
                for column in 0 ..< info.column {
                    let i = row * info.column + column
                    let x = initialPos.x + offsetX * CGFloat(column)
                    let y = initialPos.y + offsetY * CGFloat(row)
                    cardShuffled[i].position = CGPoint(x: x, y: y)
                }
            }
            for c in 0 ..< cardShuffled.count {
                addChild(cardShuffled[c])
            }
        }
        
        Common.addCredits(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Gamelogic update
        gamelogic?.update(currentTime)
        
        //Check the win condition from gamelogic and
        //do change the scene if the game is finished
        if let win = gamelogic?.win {
            if(win){
                let sequence = SKAction.sequence([
                    SKAction.wait(forDuration: 0.5),
                    SKAction.run {
                        if let gamelogic = self.gamelogic{
                            var level: String!
                            switch(gamelogic.level!){
                            case .easy:
                                level = "easy"
                            case .medium:
                                level = "medium"
                            case .hard:
                                level = "hard"
                            
                            }
                            
                            self.gameoverDelegate?.goToGameOver(sender: self, gamelogic: gamelogic, level: level)
                        }
                    }
                    ])
                run(sequence)
            }
        }
        
        //Update labels
        if let bonusTime = gamelogic?.bonusTime{
            bonusLabel?.text = String(bonusTime)
        }
        if let points = gamelogic?.points{
            scoreLabel?.text = String(points)
        }
    }
    
    func backToMainMenu(){
        changeSceneDelegate?.backToMainMenu(sender: self)
    }
    
    func onTap(sender: Button) {
        if(sender == backButton){
            errorPrevention()
        }
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
