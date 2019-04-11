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
        Common.setupBackground(scene: self, imageNamed: GameInfo.bgBlurName)
        
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
        let initialPosMedals = CGPoint(x: self.frame.width * 0.18, y: self.frame.height * 0.62)
        let yOffsetMedals = self.frame.height * 0.16
        let medalSize:CGFloat = self.frame.width * 0.18
        for i in 0..<3 {
            let medal = SKSpriteNode(imageNamed: "medal"+String(i+1))
            medal.position = CGPoint(x: initialPosMedals.x, y: initialPosMedals.y - yOffsetMedals * CGFloat(i))
            medal.size = CGSize(width: medalSize, height: medalSize)
            addChild(medal)
            
        }
        //Names
        //get the info
        var info = Preferences.getLocalHighscores()
        //display the info
        let initialPosScores = CGPoint(x: self.frame.width * 0.3, y: self.frame.height * 0.62)
        let yOffsetScores = self.frame.height * 0.16
        let initialYOffsetScores = self.frame.height * 0.05 //Offset for the score number
        print("Info from highscores: \(info)")
        for i in 0..<info.count/2 {
            var text = SKLabelNode(text: "LocalName\(i)")
            text.position = CGPoint(x: initialPosScores.x, y: initialPosScores.y - yOffsetScores * CGFloat(i))
            text.horizontalAlignmentMode = .left
            text.fontSize = 30
            text.fontName = GameInfo.fontName
            addChild(text)
            
            text = SKLabelNode(text: "99999")
            text.position = CGPoint(x: initialPosScores.x, y: initialPosScores.y - initialYOffsetScores - (yOffsetScores * CGFloat(i)))
            text.horizontalAlignmentMode = .left
            text.fontSize = 20
            addChild(text)
        }
        print(info)
        
        //***BACK BUTTON***
        backButton = Button(imageNamed: "MainMenu_button")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.15)
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
