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
    
    var placeholderText: String?
    var level: GameInfo?
    
    
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
        level = GameInfo.Easy()
        
        //BACKGROUND
        Common.setupBackground(scene: self, imageNamed: GameInfo.bgName)
        
        //back button
        backButton = Button(imageNamed: "back_arrow")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.1, y: self.frame.height * 0.95)
            backButton.scaleAspectRatio(width: self.frame.width * 0.1)
            backButton.isUserInteractionEnabled = true
            
            addChild(backButton)
        }
        
        //***SCORE***
        //score icon
        scoreIcon = SKSpriteNode(imageNamed: "score")
        if let scoreIcon = scoreIcon {
            scoreIcon.position = CGPoint(x: self.frame.width * 0.35, y: self.frame.height * 0.95)
            scoreIcon.scale(to: CGSize(width: self.frame.width * 0.12, height: self.frame.width * 0.12))
            
            addChild(scoreIcon)
        }
        //score label
        scoreLabel = SKLabelNode(text: "0")
        if let scoreLabel = scoreLabel {
            scoreLabel.position = CGPoint(x: self.frame.width * 0.43, y: self.frame.height * 0.94)
            scoreLabel.verticalAlignmentMode = .center
            scoreLabel.horizontalAlignmentMode = .left
            scoreLabel.fontSize = scoreFontSize
            
            addChild(scoreLabel)
        }
        
        //***BONUS***
        //bonus icon
        bonusIcon = SKSpriteNode(imageNamed: "bonus")
        if let bonusIcon = bonusIcon{
            bonusIcon.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.height * 0.94)
            bonusIcon.scale(to: CGSize(width: self.frame.width * 0.12, height: self.frame.width * 0.12))
            addChild(bonusIcon)
        }
        //bonus label
        bonusLabel = SKLabelNode(text: "999")
        if let bonusLabel = bonusLabel {
            bonusLabel.position = CGPoint(x: self.frame.width * 0.82, y: self.frame.height * 0.94)
            bonusLabel.verticalAlignmentMode = .center
            bonusLabel.horizontalAlignmentMode = .left
            bonusLabel.fontSize = scoreFontSize
            
            addChild(bonusLabel)
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
    
    func onTap(sender: Button) {
        print("onTap not  implemented")
    }
}
