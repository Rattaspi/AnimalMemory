//
//  MainMenuScene.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 15/02/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit
import GameplayKit
import Firebase

protocol MainMenuDelegate : class{
    func goToEasy(sender: MainMenuScene)
    func goToMedium(sender: MainMenuScene)
    func goToHard(sender: MainMenuScene)
    func goToLeaderboards(sender: MainMenuScene)
}

class MainMenuScene: SKScene, ButtonDelegate {
    
    public weak var changeSceneDelegate : MainMenuDelegate?
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var bg1 : SKSpriteNode?
    private var audioButton : Toggle?
    private var audioIcon1 : SKTexture?
    private var audioIcon2 : SKTexture?
    private var easyButton : Button?
    private var mediumButton : Button?
    private var hardButton : Button?
    private var leaderboardButton : Button?
    private var title : SKLabelNode?
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.purple
        
        //SET THE LAYER1 BACKGROUND
        bg1 = SKSpriteNode(imageNamed: GameInfo.bgName)
        if let bg1 = bg1 {
            bg1.position = view.center
            bg1.scale(to: CGSize(width: self.frame.width * bg1.frame.width / bg1.frame.height, height: self.frame.height))
            addChild(bg1)
        }
        
        //SET THE TITLE
        title = SKLabelNode(fontNamed: "TimKid")
        if let title = title{
            title.fontSize = 40
            title.text = "Animal memory"
            title.fontColor = SKColor(red: 28/255, green: 68/255, blue: 68/255, alpha: 1.0)
            title.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.7 )
            addChild(title)
        }
        
        //***AUDIO ICON***
        audioIcon1 = SKTexture(imageNamed: "MainMenu_speakeraudio")
        audioIcon2 = SKTexture(imageNamed: "MainMenu_speakernoaudio")
        audioButton = Toggle(imageNamed: "MainMenu_speakeraudio")
        if let audioIcon = audioButton{
            audioIcon.position = CGPoint(x: self.frame.width * 0.87, y: self.frame.maxY * 0.92)
            audioIcon.scale(to: CGSize(width: 52, height: 52))
            addChild(audioIcon)
            
            audioIcon.on = false
            audioIcon.delegate = self
            audioIcon.isUserInteractionEnabled = true
        }
        
        //***LEADERBOARDS BUTTON***
        leaderboardButton = Button(imageNamed: "MainMenu_highscore")
        if let leaderboardButton = leaderboardButton {
            leaderboardButton.position = CGPoint(x: self.frame.width * 0.13, y: self.frame.height * 0.93)
            leaderboardButton.scale(to: CGSize(width: 52, height: 52))
            
            addChild(leaderboardButton)
            leaderboardButton.delegate = self
            leaderboardButton.isUserInteractionEnabled = true
        }
        
        //***LEVEL BUTTONS***
        easyButton = Button(imageNamed: "MainMenu_button")
        if let easyButton = easyButton{
            easyButton.scaleAspectRatio(width: self.frame.width * 0.5)
            easyButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            easyButton.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
            
            
            addChild(easyButton)
            easyButton.createButtonText(text: "Facil")
            easyButton.delegate = self
            easyButton.isUserInteractionEnabled = true
            
        }
        mediumButton = Button(imageNamed: "MainMenu_button")
        if let mediumButton = mediumButton{
            mediumButton.scaleAspectRatio(width: self.frame.width * 0.5)
            mediumButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            mediumButton.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.4)

            addChild(mediumButton)
            mediumButton.createButtonText(text: "Normal")
            mediumButton.delegate = self
            mediumButton.isUserInteractionEnabled = true
        }
        hardButton = Button(imageNamed: "MainMenu_button")
        if let hardButton = hardButton{
            hardButton.scaleAspectRatio(width: self.frame.width * 0.5)
            hardButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            hardButton.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.3)
            
            addChild(hardButton)
            hardButton.createButtonText(text: "Dificil")
            hardButton.delegate = self
            hardButton.isUserInteractionEnabled = true
        }
        
        Common.addCredits(scene: self)
    }
    
    func onTap(sender: Button) {
        if(sender == audioButton){
            changeAudioSprite()
            //TODO enable or disable the app audio
        }
        else if(sender == easyButton){
            changeSceneDelegate?.goToEasy(sender: self)
        }
        else if(sender == mediumButton){
            changeSceneDelegate?.goToMedium(sender: self)
        }
        else if(sender == hardButton){
            changeSceneDelegate?.goToHard(sender: self)
        }
        else if (sender == leaderboardButton){
            changeSceneDelegate?.goToLeaderboards(sender: self)
        }
    }
    
    func changeAudioSprite(){
        if let audioButton = audioButton {
            if let muted = audioButton.on{
                if(muted){
                    audioButton.on = false
                    audioButton.texture = audioIcon1
                }
                else{
                    audioButton.on = true
                    audioButton.texture = audioIcon2
                }
            }
        }
    }
    
    func debugDB(){
        //DBManager.writeUserScore(name: "Test", score: -10)
        //DBManager.getUserScore()
        //DBManager.UpdateInfo(score: 2, username: "Test", userId: GameInfo.dbId)
    }
}
