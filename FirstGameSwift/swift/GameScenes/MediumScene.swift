//
//  Medium scene.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 15/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

//protocol MediumSceneDelegate : class {
//    func backToMainMenu(sender: MediumScene)
//}

class MediumScene : Scene {
    //weak var changeSceneDelegate : MediumSceneDelegate?
    //private var displayingCards: [CardSprite]?
    
    override func didMove(to view: SKView) {
        placeholderText = "MEDIUM SCENE"
        
        super.didMove(to: view)
        
        backButton?.delegate = self
    }
    
    override func onTap(sender: Button) {
        if(sender == backButton){
            changeSceneDelegate?.backToMainMenu(sender: self)
        }
    }
    
    
}
