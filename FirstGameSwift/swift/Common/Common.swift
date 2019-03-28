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
        let credits = SKLabelNode(text: "Game by: Alex Canut")
        credits.position = CGPoint(x: scene.frame.width * 0.95, y: scene.frame.height * 0.02)
        credits.fontSize = 15
        credits.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scene.addChild(credits)
    }
}
