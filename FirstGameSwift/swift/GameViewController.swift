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
import CoreLocation

import GoogleMobileAds

class GameViewController: UIViewController, MainMenuDelegate, SceneDelegate {
    
    var bannerView: GADBannerView!
    public var intersticial: GADInterstitial!
    
    func backToMainMenu(sender: SKScene) {
        if let view = self.view as? SKView{
            let scene = MainMenuScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
            scene.changeSceneDelegate = self
        }
    }
    
    func goToGameOver(sender: SKScene, gamelogic: Gamelogic, level: String) {
        if let view = self.view as? SKView{
            let scene = GameoverScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            scene.changeSceneDelegate = self
            scene.defineScores(streak: gamelogic.matchStreak, attempts: gamelogic.attempts, score: gamelogic.points, bonus: gamelogic.bonusScore)
            scene.levelFrom = level
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func goToEasy(sender: MainMenuScene) {
        if let view = self.view as? SKView {
            let scene = EasyScene (size: view.frame.size)
            scene.changeSceneDelegate = self
            scene.gameoverDelegate = self
            scene.scaleMode = .aspectFill
            scene.vc = self
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func goToMedium(sender: MainMenuScene){
        if let view = self.view as? SKView {
            let scene = MediumScene (size: view.frame.size)
            scene.changeSceneDelegate = self
            scene.gameoverDelegate = self
            scene.scaleMode = .aspectFill
            scene.vc = self
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func goToHard(sender: MainMenuScene){
        if let view = self.view as? SKView {
            let scene = HardScene (size: view.frame.size)
            scene.changeSceneDelegate = self
            scene.gameoverDelegate = self
            scene.scaleMode = .aspectFill
            scene.vc = self
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func goToLeaderboards(sender: MainMenuScene) {
        if let view = self.view as? SKView {
            let scene = LeaderboardsScene (size: view.frame.size)
            scene.changeSceneDelegate = self
            scene.uiViewController = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    let locationManager = CLLocationManager()
    
    func initLocation(){
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
        else {
            //permission
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        
        /*
        //BANNER
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        //bannerView.removeFromSuperview
        */
        
        //My add key does not work: ca-app-pub-3986547639162462/9966646591
        //Example key (it kinda works): ca-app-pub-3940256099942544/4411468910
        intersticial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        intersticial.load(request)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
           
            //Get the database id
            GameInfo.dbId = Preferences.getDbId()
            
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
    
    func presentInterstitial(){
        intersticial.present(fromRootViewController: self)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView){
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
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

//Location stuff
extension GameViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        case .denied:
            print("denied")
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        default:
            print("")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let officeLocation = CLLocation(latitude: 51.50998, longitude: -0.1337)
        if let lastLocation = locations.last {
            //process the last location
            print(lastLocation)
            if(lastLocation.distance(from: officeLocation) < 50){
                //Do stuff
                showHello()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func showHello(){
        print("User is in the location")
        
        let dialog = UIAlertController (title: "Hello!", message: "You found the office!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        dialog.addAction(action)
        present(dialog, animated: true, completion: nil)
    }
}
