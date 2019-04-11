//
//  Preferences.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 29/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import Foundation

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
    
    static func saveLocalScore(name: String, score: String){
        var checkScore = UserDefaults.standard.string(forKey: k_LOCAL1_SCORE) ?? ""
        if (checkScore == ""){
            UserDefaults.standard.set(name, forKey: k_LOCAL1_NAME)
            UserDefaults.standard.set(score, forKey: k_LOCAL1_SCORE)
            assignScore(name: name, score: score, key1: k_LOCAL1_NAME, key2: k_LOCAL1_SCORE)
        }
        //else {
         //   if(
        //}
    }
    
    private static func assignScore(name: String, score: String, key1: String, key2: String){
        UserDefaults.standard.set(name, forKey: key1)
        UserDefaults.standard.set(score, forKey: key2)
        
    }
    
    static func toggleSound(){
        let soundOn = isSoundOn()
        UserDefaults.standard.set(!soundOn, forKey: k_SOUND_ON)
    }
}
