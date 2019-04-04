//
//  GameoverScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 28/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

class GameoverScene: SKScene, ButtonDelegate {
    weak var changeSceneDelegate : SceneDelegate?
    
    var backButton: Button?
    var saveButton: Button?
    var title: SKLabelNode?
    
    //Score display
    var scores: [Int]?
    let scoreFontSize: Int = 20
    
    //Display info
    let buttonWidth: CGFloat = 0.35
    
    override func didMove(to view: SKView) {
        //***BACKGROUND***
        Common.setupBackground(scene: self)
        
        //***SCREEN TITLE***
        title = SKLabelNode(text: "You won!")
        if let title = title {
            title.fontName = GameInfo.fontName
            title.fontSize = 40
            title.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.85)
            
            addChild(title)
        }
        
        //***SCORE DISPLAY***
        //labels
        let placeholderValue: Int = 99999
        let initialPos = CGPoint(x: self.frame.width * 0.11, y: self.frame.height * 0.70)
        let yOffset = self.frame.height * 0.06
        let xPos2 = self.frame.width * 0.9
        let names = [
            "Match streak",
            "Attempts",
            "Score",
            "Bonus",
            "Total score"
        ]
        
        for i in 0..<names.count {
            let label = SKLabelNode(text: names[i])
            label.position = CGPoint(x: initialPos.x, y: initialPos.y - yOffset * CGFloat(i))
            label.fontSize = 24
            label.horizontalAlignmentMode = .left
            label.fontColor = UIColor.black
            addChild(label)
            
            //use this for to add the values too
            if let scores = scores {
                let label2 = SKLabelNode(text: String(scores[i]))
                label2.position = CGPoint(x: xPos2, y: initialPos.y - yOffset * CGFloat(i))
                label2.fontSize = 24
                label2.horizontalAlignmentMode = .right
                label2.fontColor = UIColor.black
                addChild(label2)
            }
        }
        
        //***BACK BUTTON***
        backButton = Button(imageNamed: "MainMenu_button")
        if let backButton = backButton {
            backButton.position = CGPoint(x: self.frame.width * 0.28, y: self.frame.height * 0.2)
            backButton.scaleAspectRatio(width: self.frame.width * buttonWidth)
            backButton.isUserInteractionEnabled = true
            
            addChild(backButton)
            backButton.createButtonText(text: "Menu")
        }
        backButton?.delegate = self
        
        //Save button
        saveButton = Button(imageNamed: "MainMenu_button")
        if let saveButton = saveButton {
            saveButton.position = CGPoint(x: self.frame.width * 0.72, y: self.frame.height * 0.2)
            saveButton.scaleAspectRatio(width: self.frame.width * buttonWidth)
            saveButton.isUserInteractionEnabled = true
            
            addChild(saveButton)
            saveButton.createButtonText(text: "Save & menu")
        }
        saveButton?.delegate = self
        
        //Input field to add a name for the highscores
        //https://stackoverflow.com/questions/48896748/how-to-add-uitextfield-to-skscene-spritekit-game
        
        Common.addCredits(scene: self)
    }

    func defineScores(streak: Int, attempts: Int, score: Int, bonus: Int){
        scores = [
            streak,
            attempts,
            score,
            bonus,
            score + bonus
        ]
    }
    
    func onTap(sender: Button) {
        if(sender == backButton || sender == saveButton){
            changeSceneDelegate?.backToMainMenu(sender: self)
        }
    }
}
