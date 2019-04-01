//
//  GameoverScene.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 28/3/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

class GameoverScene: Scene {
    
    override func didMove(to view: SKView) {
        super.placeholderText = "GAME OVER"
        super.didMove(to: view)
        backButton?.delegate = self
        
        
    }
    
    override func onTap(sender: Button) {
        if(sender == backButton){
            changeSceneDelegate?.backToMainMenu(sender: self)
        }
    }
}
