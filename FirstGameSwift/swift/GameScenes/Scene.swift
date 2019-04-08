//
//  GameScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 21/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

protocol SceneDelegate: class {
    func backToMainMenu(sender: SKScene)
    func goToGameOver(sender: SKScene, gamelogic: Gamelogic)
}

class Scene: SKScene, ButtonDelegate {
    weak var changeSceneDelegate : SceneDelegate?
    weak var gameoverDelegate: SceneDelegate?
    
    var easyText : SKLabelNode?
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
        Common.setupBackground(scene: self)
        
        //placeholder screen title
        easyText = SKLabelNode(text: placeholderText)
        if let easyText = easyText {
            easyText.position = CGPoint (x: self.frame.width * 0.5, y: self.frame.height * 0.5)
            easyText.fontSize = 40
            easyText.fontName = "TimKid"
            addChild(easyText)
        }
        
        //back button
        backButton = Button(imageNamed: "MainMenu_button")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.155, y: self.frame.height * 0.03)
            backButton.scaleAspectRatio(width: self.frame.width * 0.25)
            backButton.isUserInteractionEnabled = true
            
            addChild(backButton)
            backButton.createButtonText(text: "Menu")
        }
        
        //***SCORE***
        //score icon
        scoreIcon = SKSpriteNode(imageNamed: "score")
        if let scoreIcon = scoreIcon {
            scoreIcon.position = CGPoint(x: self.frame.width * 0.15, y: self.frame.height * 0.95)
            scoreIcon.scale(to: CGSize(width: self.frame.width * 0.12, height: self.frame.width * 0.12))
            
            addChild(scoreIcon)
        }
        //score label
        scoreLabel = SKLabelNode(text: "0")
        if let scoreLabel = scoreLabel {
            scoreLabel.position = CGPoint(x: self.frame.width * 0.23, y: self.frame.height * 0.94)
            scoreLabel.verticalAlignmentMode = .center
            scoreLabel.horizontalAlignmentMode = .left
            scoreLabel.fontSize = scoreFontSize
            
            addChild(scoreLabel)
        }
        
        //***BONUS***
        //bonus icon
        bonusIcon = SKSpriteNode(imageNamed: "medal1")
        if let bonusIcon = bonusIcon{
            bonusIcon.position = CGPoint(x: self.frame.width * 0.65, y: self.frame.height * 0.94)
            bonusIcon.scale(to: CGSize(width: self.frame.width * 0.12, height: self.frame.width * 0.12))
            addChild(bonusIcon)
        }
        //bonus label
        bonusLabel = SKLabelNode(text: "999")
        if let bonusLabel = bonusLabel {
            bonusLabel.position = CGPoint(x: self.frame.width * 0.72, y: self.frame.height * 0.94)
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
                            self.gameoverDelegate?.goToGameOver(sender: self, gamelogic: gamelogic)
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
    
    func checkLevel() {
       
    }
    
    func onTap(sender: Button) {
        print("onTap not  implemented")
    }
}
