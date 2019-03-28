//
//  HardScene.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 15/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

//protocol HardSceneDelegate : class {
//    func backToMainMenu(sender: HardScene)
//}

class HardScene : Scene {
    //weak var changeSceneDelegate : HardSceneDelegate?
    //private var displayingCards: [CardSprite]?
    
    override func didMove(to view: SKView) {
        placeholderText = "HARD SCENE"
        
        super.didMove(to: view)
        
        backButton?.delegate = self
    }
    
    override func onTap(sender: Button) {
        if(sender == backButton){
            changeSceneDelegate?.backToMainMenu(sender: self)
        }
    }
}
