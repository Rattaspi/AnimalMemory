//
//  LeaderboardsScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 21/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

class LeaderboardsScene: SKScene, ButtonDelegate {
    weak var changeSceneDelegate: SceneDelegate?
    
    var backButton: Button?
    var leaderboardTittle: SKLabelNode?
    
    override func didMove(to view: SKView) {
        //***BACKGROUND***
        Common.setupBackground(scene: self)
        
        //***TITLE***
        leaderboardTittle = SKLabelNode(text: "Highscores")
        if let leaderboardTittle = leaderboardTittle {
            leaderboardTittle.fontName = GameInfo.fontName
            leaderboardTittle.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.8)
            leaderboardTittle.fontSize = 40
            addChild(leaderboardTittle)
        }
        
        //***BACK BUTTON***
        backButton = Button(imageNamed: "MainMenu_button")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.2)
            backButton.scaleAspectRatio(width: self.frame.width * 0.45)
            backButton.isUserInteractionEnabled = true
            
            addChild(backButton)
            backButton.createButtonText(text: "Menu")
            backButton.delegate = self
        }
        
        Common.addCredits(scene: self)
    }
    
    func onTap(sender: Button) {
        if(sender == backButton){
            changeSceneDelegate?.backToMainMenu(sender: self)
        }
    }
}
