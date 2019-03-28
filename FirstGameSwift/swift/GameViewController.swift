//
//  GameViewController.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 15/02/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, MainMenuDelegate, SceneDelegate /*EasySceneDelegate, MediumSceneDelegate, HardSceneDelegate, LeaderboardSceneDelegate*/ {    
    
    func backToMainMenu(sender: MediumScene) {
        if let view = self.view as? SKView{
            let scene = MainMenuScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
    }
    
    func backToMainMenu(sender: HardScene) {
        if let view = self.view as? SKView{
            let scene = MainMenuScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
    }
    
    func backToMainMenu(sender: EasyScene) {
        if let view = self.view as? SKView{
            let scene = MainMenuScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
    }
    
    func backToMainMenu(sender: LeaderboardsScene) {
        if let view = self.view as? SKView{
            let scene = MainMenuScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
    }
    
    
    func goToEasy(sender: MainMenuScene) {
        if let view = self.view as? SKView {
            let scene = EasyScene (size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
    }
    func goToMedium(sender: MainMenuScene){
        if let view = self.view as? SKView {
            let scene = MediumScene (size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
    }
    func goToHard(sender: MainMenuScene){
        if let view = self.view as? SKView {
            let scene = HardScene (size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
    }
    func goToLeaderboards(sender: MainMenuScene) {
        /*
        if let view = self.view as? SKView {
            let scene = LeaderboardsScene (size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
           
            let scene = MainMenuScene(size: view.frame.size)
            scene.changeSceneDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
            // Present the scene
            view.presentScene(scene)
            
            
            //view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
