//
//  Preferences.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 29/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit
import Foundation

class Preferences {
    
    static let k_SOUND_ON = "SOUND_ON"
    static let k_MY_DB_ID = "DB_ID"
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
    
    static func saveSoundState(_ b : Bool){
        UserDefaults.standard.set(b, forKey: k_SOUND_ON)
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
        for i in 0..<info.count/2 {
            let name: String  = info[i*2]
            let score: String = info[i*2+1]
            UserDefaults.standard.set(String(name), forKey: "LOCAL\(i+1)_NAME")
            UserDefaults.standard.set(String(score), forKey: "LOCAL\(i+1)_SCORE")
        }
    }
    
    static func getDbId() -> String {
        if let _ = UserDefaults.standard.object(forKey: k_MY_DB_ID){
            return UserDefaults.standard.string(forKey: k_MY_DB_ID)!
            
        }
        else {
            let id = UUID().uuidString
            UserDefaults.standard.set(String(id), forKey: k_MY_DB_ID)
            return id
        }
        
    }
}
