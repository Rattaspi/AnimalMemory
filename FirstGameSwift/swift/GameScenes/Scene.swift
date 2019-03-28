//
//  GameScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 21/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

protocol SceneDelegate: class {
    func backToMainMenu(sender: EasyScene)
    func backToMainMenu(sender: MediumScene)
    func backToMainMenu(sender: HardScene)
    func backToMainMenu(sender: LeaderboardsScene)
    func backToMainMenu()
}

class Scene: SKScene, ButtonDelegate {
    weak var changeSceneDelegate : SceneDelegate?
    weak var gameoverDelegate: SceneDelegate?
    
    public var easyText : SKLabelNode?
    var placeholderText: String?
    
    var displayingCards: [CardSprite]?
    var gamelogic: Gamelogic?
    var backButton: Button?
    
    override func didMove(to view: SKView) {        
        //BACKGROUND
        let background = SKSpriteNode(imageNamed: "MainMenu_bg")
        background.position = view.center
        background.scale(to: CGSize(width: self.frame.width * background.frame.width / background.frame.height, height: self.frame.height))
        addChild(background)
        
        //placeholder screen title
        easyText = SKLabelNode(text: placeholderText)
        if let easyText = easyText {
            easyText.position = CGPoint (x: self.frame.width * 0.5, y: self.frame.height * 0.5)
            easyText.fontSize = 40
            easyText.fontName = "TimKid"
            addChild(easyText)
        }
        
        //placeholder back button
        backButton = Button(imageNamed: "MainMenu_button")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.15, y: self.frame.height * 0.9)
            backButton.scaleAspectRatio(width: self.frame.width * 0.3)
            backButton.isUserInteractionEnabled = true
            
            addChild(backButton)
            backButton.createButtonText(text: "Atras")
        }
        
        Common.addCredits(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let win = gamelogic?.checkWin() {
            if(win){
                //PROBLEM - gameoverDelegate is null but im assigning it from GameViewController.swift
                gameoverDelegate?.backToMainMenu()
            }
        }
    }
    
    func onTap(sender: Button) {
        print("onTap not  implemented")
    }
}
