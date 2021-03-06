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
    
    let analytics = AnalyticsManager()
    
    var label : SKLabelNode?
    var bg = [SKSpriteNode]()
    var audioButton : Toggle?
    var audioIcon1 : SKTexture?
    var audioIcon2 : SKTexture?
    var easyButton : Button?
    var mediumButton : Button?
    var hardButton : Button?
    var leaderboardButton : Button?
    var title : SKLabelNode?
    var tiltManager: TiltManager!
    var tiltMaxDistance: CGFloat = 30.0
    
    override func didMove(to view: SKView) {
        tiltManager = TiltManager()
        AudioManager.shared.play()
        
        //SET THE LAYER1 BACKGROUND
        for i in 0..<6 {
            let layer = SKSpriteNode(imageNamed: "bg\(i)")
            layer.position = view.center
            layer.scale(to: CGSize(width: self.frame.width * layer.frame.width / layer.frame.height, height: self.frame.height))
            addChild(layer)
            bg.append(layer)
        }
        
        //SET THE TITLE
        title = SKLabelNode(fontNamed: "TimKid")
        if let title = title{
            title.fontSize = 40
            title.text = NSLocalizedString("Animal memory", comment: "")
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
            
            audioIcon.on = Preferences.isSoundOn()
            AudioManager.globalSoundOn = audioIcon.on
            if(!audioIcon.on!){
                audioIcon.texture = audioIcon2
            }
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
            easyButton.createButtonText(text: NSLocalizedString("Easy", comment:""))
            easyButton.delegate = self
            easyButton.isUserInteractionEnabled = true
            
        }
        mediumButton = Button(imageNamed: "MainMenu_button")
        if let mediumButton = mediumButton{
            mediumButton.scaleAspectRatio(width: self.frame.width * 0.5)
            mediumButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            mediumButton.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.4)

            addChild(mediumButton)
            mediumButton.createButtonText(text: NSLocalizedString("Normal", comment:""))
            mediumButton.delegate = self
            mediumButton.isUserInteractionEnabled = true
        }
        hardButton = Button(imageNamed: "MainMenu_button")
        if let hardButton = hardButton{
            hardButton.scaleAspectRatio(width: self.frame.width * 0.5)
            hardButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            hardButton.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.3)
            
            addChild(hardButton)
            hardButton.createButtonText(text: NSLocalizedString("Hard", comment:""))
            hardButton.delegate = self
            hardButton.isUserInteractionEnabled = true
        }
        
        Common.addCredits(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        var tiltToUse = tiltManager.tiltX * 75
        if(tiltToUse > self.tiltMaxDistance){
            tiltToUse = self.tiltMaxDistance
        }
        else if (tiltToUse < -self.tiltMaxDistance){
            tiltToUse = -self.tiltMaxDistance
        }
        //bg1?.position = CGPoint(x: self.view!.center.x + tiltToUse, y: self.view!.center.y)
        let tiltLayers: [CGFloat] = [1.0, 0.85, 0.8, 0.65, 0.4, 0.2]
        for i in 0..<6 {
            let layeredTilt = tiltToUse * tiltLayers[i]
            bg[i].position = CGPoint(x: self.view!.center.x + layeredTilt, y: self.view!.center.y)
        }
    }
    
    func onTap(sender: Button) {
        if(sender == audioButton){
            changeAudioSprite()
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
                    audioButton.texture = audioIcon2
                    AudioManager.shared.off()
                }
                else{
                    audioButton.on = true
                    audioButton.texture = audioIcon1
                    AudioManager.shared.on()
                }
                Preferences.saveSoundState(audioButton.on!)
                AudioManager.globalSoundOn = audioButton.on
            }
        }
    }
}
