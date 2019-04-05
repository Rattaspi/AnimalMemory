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
    var localButton: Button?
    var globalButton: Button?
    
    override func didMove(to view: SKView) {
        //***BACKGROUND***
        Common.setupBackground(scene: self)
        
        //***TITLE***
        let leaderboardTittle = SKLabelNode(text: "Highscores")
        leaderboardTittle.fontName = GameInfo.fontName
        leaderboardTittle.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.85)
        leaderboardTittle.fontSize = 40
        addChild(leaderboardTittle)
        
        
        //***LEADERBOARD SELECTION***
        //Local
        localButton = Button(imageNamed: "MainMenu_button")
        if let localButton = localButton {
            localButton.position = CGPoint(x: self.frame.width * 0.3, y: self.frame.height * 0.75)
            localButton.scaleAspectRatio(width: self.frame.width * 0.3)
            localButton.isUserInteractionEnabled = true
            
            addChild(localButton)
            localButton.createButtonText(text: "Local")
            localButton.delegate = self
        }
        
        //Global
        globalButton = Button(imageNamed: "MainMenu_button")
        if let globalButton = globalButton {
            globalButton.position = CGPoint(x: self.frame.width * 0.7, y: self.frame.height * 0.75)
            globalButton.scaleAspectRatio(width: self.frame.width * 0.3)
            globalButton.isUserInteractionEnabled = true
            
            addChild(globalButton)
            globalButton.createButtonText(text: "Global")
            globalButton.delegate = self
        }
        
        //***SCORES***
        //Medals
        let initialPos = CGPoint(x: self.frame.width * 0.18, y: self.frame.height * 0.62)
        let yOffset = self.frame.height * 0.16
        let medalSize:CGFloat = self.frame.width * 0.18
        for i in 0..<3 {
            let medal = SKSpriteNode(imageNamed: "medal"+String(i+1))
            medal.position = CGPoint(x: initialPos.x, y: initialPos.y - yOffset * CGFloat(i))
            medal.size = CGSize(width: medalSize, height: medalSize)
            addChild(medal)
            print(i)
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
