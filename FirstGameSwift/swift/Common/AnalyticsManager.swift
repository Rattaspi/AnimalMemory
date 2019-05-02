//
//  AnalyticsManager.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 02/05/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import Foundation
import FirebaseAnalytics
//Analytics.logEvent("nextLevel", parameters: ["levelNumber": 2])

class AnalyticsManager {
    func saveBonusAnalytic(level: Gamelogic.Level, time: Int){
        switch level {
        case .easy:
            Analytics.logEvent("easy", parameters: ["time_remaining" : time])
        case .medium:
            Analytics.logEvent("medium", parameters: ["time_remaining" : time])
        case .hard:
            Analytics.logEvent("hard", parameters: ["time_remaining" : time])
        }
    }
    
    static func debug(){
        print("sending analytic")
        Analytics.logEvent("TEST", parameters: ["Test" : 2 as NSObject])
    }
}
