//
//  LeaderboardsScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 21/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

class LeaderboardsScene: SKScene, ButtonDelegate {
    weak var changeSceneDelegate: SceneDelegate?
	
	let analytics = AnalyticsManager()
    
    var backButton: Button?
    var localButton: Button?
    var globalButton: Button?
    
    //true-> display local
    //false-> display global
    var local = true;
	
	var info = [String]()
	var globalInfo = [String]()
	var displayingInfo = [SKLabelNode]()
	var uiViewController: GameViewController!
    
    override func didMove(to view: SKView) {
		analytics.openSceneEvent(sceneName: "leaderboards_scene")
		
		//***BACKGROUND***
        Common.setupBackground(scene: self, imageNamed: GameInfo.bgBlurName)
        
        //***TITLE***
        let leaderboardTittle = SKLabelNode(text: NSLocalizedString("Highscores", comment: ""))
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
            localButton.createButtonText(text: NSLocalizedString("local", comment: ""))
            localButton.delegate = self
        }
        
        //Global
        globalButton = Button(imageNamed: "MainMenu_button")
        if let globalButton = globalButton {
            globalButton.position = CGPoint(x: self.frame.width * 0.7, y: self.frame.height * 0.75)
            globalButton.scaleAspectRatio(width: self.frame.width * 0.3)
            globalButton.isUserInteractionEnabled = true
            
            addChild(globalButton)
            globalButton.createButtonText(text: NSLocalizedString("global", comment: ""))
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
        //***NAMES AND SCORES
        //get the info database info
		DBManager.getHighscores { scores in
			for i in 0..<6 {
				if(i < scores.count){
					self.globalInfo.append(scores[i])
				}
				else{
					self.globalInfo.append("")
				}
			}
		}
		//get the local storage info
        info = Preferences.getLocalHighscores()
		
        //display the info
        let initialPosScores = CGPoint(x: self.frame.width * 0.3, y: self.frame.height * 0.62)
        let yOffsetScores = self.frame.height * 0.16
        let initialYOffsetScores = self.frame.height * 0.05 //Offset for the score number
        for i in 0..<info.count/2 {
            var text = SKLabelNode(text: info[i*2])
            text.position = CGPoint(x: initialPosScores.x, y: initialPosScores.y - yOffsetScores * CGFloat(i))
            text.horizontalAlignmentMode = .left
            text.fontSize = 30
            text.fontName = GameInfo.fontName
            addChild(text)
			displayingInfo.append(text)
            
            text = SKLabelNode(text: info[i*2 + 1])
            text.position = CGPoint(x: initialPosScores.x, y: initialPosScores.y - initialYOffsetScores - (yOffsetScores * CGFloat(i)))
            text.horizontalAlignmentMode = .left
            text.fontSize = 20
            addChild(text)
			displayingInfo.append(text)
        }
        
        //***BACK BUTTON***
        backButton = Button(imageNamed: "back_arrow")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.1, y: self.frame.height * 0.95)
            backButton.scaleAspectRatio(width: self.frame.width * 0.09)
            backButton.isUserInteractionEnabled = true
            
            addChild(backButton)
            backButton.delegate = self
        }
        
        Common.addCredits(scene: self)
		
		uiViewController.presentInterstitial()
		
    }
	
	override func update(_ currentTime: TimeInterval) {
		if(local){
			localButton?.scaleAspectRatio(width: self.frame.width * 0.4)
			globalButton?.scaleAspectRatio(width: self.frame.width * 0.3)
		}
		else{
			globalButton?.scaleAspectRatio(width: self.frame.width * 0.4)
			localButton?.scaleAspectRatio(width: self.frame.width * 0.3)
		}
	}
    
    func onTap(sender: Button) {
        if(sender == backButton){
            changeSceneDelegate?.backToMainMenu(sender: self)
        }
		else if(sender == localButton){
			local = true
			updateDisplayedScores()
		}
		else if(sender == globalButton){
			local = false
			updateDisplayedScores()
			
		}
    }
	
	func updateDisplayedScores() {
		if(local){
			for i in 0..<displayingInfo.count {
				displayingInfo[i].text = info[i]
			}
		}
		else {
			for i in 0..<displayingInfo.count {
				displayingInfo[i].text = globalInfo[i]
			}
		}
	}
}
