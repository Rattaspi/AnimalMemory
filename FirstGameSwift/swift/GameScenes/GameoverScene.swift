//
//  GameoverScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 28/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit
import UIKit

class GameoverScene: SKScene, ButtonDelegate, UITextFieldDelegate {
    weak var changeSceneDelegate : SceneDelegate?
    
    let analytics = AnalyticsManager()
    let dbManager = DBManager()
    
    var backButton: Button?
    var saveButton: Button?
    var title: SKLabelNode?
    
    var textField = UITextField()
    var placeholderText = "Instert name"
    var textFieldButton = Button(imageNamed: "input_field")
    var initialInputFieldPos: CGPoint?
    
    var levelFrom: String!
    
    //Score display
    var scores: [Int]?
    let scoreFontSize: Int = 20
    
    //Display info
    let buttonWidth: CGFloat = 0.35
    
    override func didMove(to view: SKView) {
        
        //***BACKGROUND***
        Common.setupBackground(scene: self, imageNamed: GameInfo.bgBlurName)
        
        //***SCREEN TITLE***
        title = SKLabelNode(text: NSLocalizedString("win", comment: ""))
        if let title = title {
            title.fontName = GameInfo.fontName
            title.fontSize = 40
            title.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.85)
            
            addChild(title)
        }
        
        //***SCORE DISPLAY***
        //labels
        let initialPos = CGPoint(x: self.frame.width * 0.11, y: self.frame.height * 0.70)
        let yOffset = self.frame.height * 0.06
        let xPos2 = self.frame.width * 0.9
        let names = [
            NSLocalizedString("match streak", comment: ""),
            NSLocalizedString("attempts", comment: ""),
            NSLocalizedString("score", comment: ""),
            NSLocalizedString("bonus", comment: ""),
            NSLocalizedString("total", comment: "")
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
            backButton.createButtonText(text: NSLocalizedString("menu", comment: ""))
        }
        backButton?.delegate = self
        
        //Save button
        saveButton = Button(imageNamed: "MainMenu_button")
        if let saveButton = saveButton {
            saveButton.position = CGPoint(x: self.frame.width * 0.72, y: self.frame.height * 0.2)
            saveButton.scaleAspectRatio(width: self.frame.width * buttonWidth)
            saveButton.isUserInteractionEnabled = true
            
            addChild(saveButton)
            saveButton.createButtonText(text: NSLocalizedString("save & menu", comment: ""))
        }
        saveButton?.delegate = self
        
        //Input field to add a name for the highscores
        textField = UITextField(frame: CGRect(x: 0, y: -200, width: 10, height: 10))
        view.addSubview(textField)
        textField.delegate =  self
        textField.isUserInteractionEnabled = true
        
        initialInputFieldPos = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.3)
        textFieldButton.position = initialInputFieldPos!
        var deviceName: String = UIDevice.current.name
        let savedName = Preferences.getName()
        if(savedName != ""){
            deviceName = savedName
        }
        if(deviceName.count > 11){
            deviceName = String(deviceName.prefix(11))
        }
        textFieldButton.createButtonText(text: deviceName) //11 letters max
        textFieldButton.buttonText?.fontSize = 60
        textFieldButton.alignTextLeft()
        textFieldButton.isUserInteractionEnabled = true;
        textFieldButton.delegate = self
        textFieldButton.scaleAspectRatio(width: self.frame.width * 0.5)
        addChild(textFieldButton)
        
        
        
        Common.addCredits(scene: self)
    }
    
    override func willMove(from view: SKView) {
        textField.resignFirstResponder()
        textField.removeFromSuperview()
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
        if(sender == backButton ){
            changeSceneDelegate?.backToMainMenu(sender: self)
            analytics.isScoreSaved(true, level: levelFrom)
        }
        else if(sender == saveButton){
            if let text = textFieldButton.buttonText?.text {
                if (text != "") {
                    Preferences.saveScore(name: text, score: scores![4])
                    Preferences.saveName(name: text)
                    dbManager.updateInfo(score: scores![scores!.count-1], username: text, userId: GameInfo.dbId)
                    analytics.isScoreSaved(true, level: levelFrom)
                    changeSceneDelegate?.backToMainMenu(sender: self)
                }
            }
            
        }
        else if(sender == textFieldButton){
            textField.becomeFirstResponder()
            if let initialPos = initialInputFieldPos{
                textFieldButton.position.y = initialPos.y + self.frame.height * 0.2
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if i click anywhere on the screen the text field
        //loses focus
        textField.resignFirstResponder()
        if let initialPos = initialInputFieldPos{
            textFieldButton.position = initialPos
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string) as String
        
        let newStr = String(newString.prefix(11))
        
        textFieldButton.buttonText?.text = newStr
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let initialPos = initialInputFieldPos{
            textFieldButton.position = initialPos
        }
        return true
    }
}
