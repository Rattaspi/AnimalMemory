//
//  Preferences.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 29/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

class Preferences {
    
    static let k_SOUND_ON = "SOUND_ON"
    static let k_LOCAL1_NAME = "LOCAL1_NAME"
    static let k_LOCAL2_NAME = "LOCAL2_NAME"
    static let k_LOCAL3_NAME = "LOCAL3_NAME"
    static let k_LOCAL1_SCORE = "LOCAL1_SCORE"
    static let k_LOCAL2_SCORE = "LOCAL2_SCORE"
    static let k_LOCAL3_SCORE = "LOCAL3_SCORE"
    
    static func isSoundOn() -> Bool {
        if let _ = UserDefaults.standard.object(forKey: k_SOUND_ON){
            let soundOn =  UserDefaults.standard.bool(forKey: k_SOUND_ON)
            return soundOn
        }
        return true
    }
    
    static func getLocalHighscores() -> [String] {
        var info = [String]()
        info.append(UserDefaults.standard.string(forKey: k_LOCAL1_NAME) ?? "")
        info.append(UserDefaults.standard.string(forKey: k_LOCAL1_SCORE) ?? "")
    
        info.append(UserDefaults.standard.string(forKey: k_LOCAL2_NAME) ?? "")
        info.append(UserDefaults.standard.string(forKey: k_LOCAL2_SCORE) ?? "")
    
        info.append(UserDefaults.standard.string(forKey: k_LOCAL3_NAME) ?? "")
        info.append(UserDefaults.standard.string(forKey: k_LOCAL3_SCORE) ?? "")
        return info
    }
    
    static func saveScore(name: String, score: Int){
        var info = getLocalHighscores()
        var names = [String]()
        var scores = [Int]()
        
        for i in 0..<info.count/2 {
            names.append(info[i*2])
            scores.append(Int(info[i*2 + 1]) ?? 0)
        }
        
        var done = false
        for i in 0..<scores.count {
            if !done{
                if(score > scores[i] || scores[i] == nil){
                    scores.insert(score, at: i)
                    names.insert(name, at: i)
                    done = true
                }
            }
        }
        
        for i in 0..<info.count/2 {
            info[i*2] = names[i]
            info[i*2 + 1] = String(scores[i])
        }
        
        
        updateAllHighscores(info: info)
    }
    
    static func updateAllHighscores(info: [String]){
        print("Array to update: \(info)")
        
        for i in 0..<info.count/2 {
            print(info[i*2])
            UserDefaults.standard.set("Try", forKey: String("LOCAL\(i)_NAME"))
            UserDefaults.standard.set(info[i*2 + 1], forKey: String("LOCAL\(i)_SCORE"))
            //assignScore(name: info[i*2], score: info[i*2+1], key1: "LOCAL\(i)_NAME", key2: "LOCAL\(i)_SCORE")
        }
        //UserDefaults.standard.set("BOYE", forKey: k_LOCAL3_NAME)
        print("After update: \(getLocalHighscores())")
    
    }
    
    private static func assignScore(name: String, score: String, key1: String, key2: String){
        print("TRYING TO ASIGN")
        UserDefaults.standard.set(name, forKey: key1)
        UserDefaults.standard.set(score, forKey: key2)
    }
    
    /*
    static func saveLocalScore(name: String, score: String){
        let scores = getLocalHighscores()
        for i in 0..<scores.count/2 {
            if(scores[i*2 + 1] == ""){
                assignScore(name: name, score: score, key1: "k_LOCAL\(i)_NAME", key2: "k_LOCAL\(i)_SCORE")
            }
            else {
                if(Int(score)! > Int(scores[i*2 + 1])!){
                    
                }
            }
        }
    }
    
    private static func shiftAndAssign(info: [String], name: String, score: String, index: Int){
        for i in index..
    }
    
    private static func assignScore(name: String, score: String, key1: String, key2: String){
        UserDefaults.standard.set(name, forKey: key1)
        UserDefaults.standard.set(score, forKey: key2)
        
    }
     */
 
    static func toggleSound(){
        let soundOn = isSoundOn()
        UserDefaults.standard.set(!soundOn, forKey: k_SOUND_ON)
    }
}
