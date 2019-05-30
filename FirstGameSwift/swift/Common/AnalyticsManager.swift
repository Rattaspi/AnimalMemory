//
//  AnalyticsManager.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 02/05/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import Foundation
import FirebaseAnalytics

class AnalyticsManager {
    func saveBonusAnalytic(level: Gamelogic.Level, time: Int){
        switch level {
        case .easy:
            Analytics.logEvent("bonus_time", parameters: ["level" : "easy", "time_remaining" : time])
        case .medium:
            Analytics.logEvent("bonus_time", parameters: ["level" : "medium", "time_remaining" : time])
        case .hard:
            Analytics.logEvent("bonus_time", parameters: ["level" : "hard", "time_remaining" : time])
        }
    }
    
    func openSceneEvent(sceneName: String){
        Analytics.logEvent("open_view", parameters: ["scene" : sceneName])
    }
    
    func gameCancelled(time: Int){
        Analytics.logEvent("game_cancelled", parameters: ["time_remaining" : time])
    }
    
    func isScoreSaved(_ hasSaved: Bool, level: String){
        if(hasSaved){
            Analytics.logEvent("saved_score", parameters: ["saved" : "Yes", "level" : level])
        }
        else {
            Analytics.logEvent("saved_score", parameters: ["saved" : "No", "level" : level])
        }
    }
    
    func registerSoundState(state: Bool){
        if(state){
            Analytics.logEvent("sound", parameters: ["state" : "on"])
        }
        else {
            Analytics.logEvent("sound", parameters: ["state" : "off"])
        }
    }
}
