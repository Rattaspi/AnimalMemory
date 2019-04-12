//
//  Button.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 07/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

protocol ButtonDelegate: class {
    func onTap(sender: Button)
}

class Button: SKSpriteNode {
    
    weak var delegate: ButtonDelegate?
    public var buttonText : SKLabelNode?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.scale(by: 0.85, duration: 0.1)
        run(action)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.scale(by: 1.0/0.85, duration: 0.1)
        let sequence = SKAction.sequence([SKAction.playSoundFileNamed("sfx_click.wav", waitForCompletion: false),
                                          action])
        
        run(sequence)
        
        if let touch = touches.first, let parent = parent{
            if frame.contains(touch.location(in: parent)){
                if let delegate = delegate {
                    delegate.onTap(sender: self)
                }
            }
        }
    }
    
    func scaleAspectRatio(width w : CGFloat){
        self.scale(to: CGSize(width: w, height: w / self.frame.width * self.frame.height))
    }
    func scaleAspectRatio(height h : CGFloat){
        self.scale(to: CGSize(width: h / self.frame.height * self.frame.width, height: h))
    }
    
    func createButtonText(text t : String?){
        if let t = t {
            buttonText = SKLabelNode(text: t)
            if let buttonText = buttonText{
                buttonText.fontName = "TimKid"
                buttonText.fontSize = 100
                buttonText.verticalAlignmentMode = .center
                addChild(buttonText)
            }
        }
    }
    
    func alignTextLeft(){
        buttonText?.horizontalAlignmentMode = .left
        buttonText?.position.x -= (self.frame.width / 2) - (self.frame.width * 0.05)
    }
}
