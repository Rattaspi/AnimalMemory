//
//  LeaderboardsScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 21/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

protocol LeaderboardSceneDelegate: class {
    func backToMainMenu(sender: LeaderboardsScene)
}

class LeaderboardsScene: SKScene, ButtonDelegate {
    weak var changeSceneDelegate: LeaderboardSceneDelegate?
    
    var backButton: Button?
    var leaderboardTittle: SKLabelNode?
    
    override func didMove(to view: SKView) {
        //BACKGROUND
        let background = SKSpriteNode(imageNamed: "MainMenu_bg")
        background.position = view.center
        background.scale(to: CGSize(width: self.frame.width * background.frame.width / background.frame.height, height: self.frame.height))
        addChild(background)
        
        //BACK BUTTON
        backButton = Button(imageNamed: "MainMenu_button")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.15, y: self.frame.height * 0.9)
            backButton.scaleAspectRatio(width: self.frame.width * 0.3)
            backButton.isUserInteractionEnabled = true
            
            addChild(backButton)
            backButton.createButtonText(text: "Atras")
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
