//
//  Common.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 21/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

class Common {    
    static func addCredits(scene : SKScene){
        let credits = SKLabelNode(text: NSLocalizedString("Game by:", comment: "")+" Alex Canut")
        credits.position = CGPoint(x: scene.frame.width * 0.95, y: scene.frame.height * 0.02)
        credits.fontSize = 15
        credits.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scene.addChild(credits)
    }
    
    static func setupBackground(scene: SKScene, imageNamed: String){
        let background = SKSpriteNode(imageNamed: imageNamed)
        if let view = scene.view{
            background.position = view.center
        }
        background.scale(to: CGSize(width: scene.frame.width * background.frame.width / background.frame.height, height: scene.frame.height))
        scene.addChild(background)
    }
}
