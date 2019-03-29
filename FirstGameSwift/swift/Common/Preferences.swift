//
//  Preferences.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 29/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import Foundation

class Preferences {
    
    let k_SOUND_ON = "SOUND_ON"
    
    func isSoundOn() -> Bool {
        if let _ = UserDefaults.standard.object(forKey: k_SOUND_ON){
            let soundOn =  UserDefaults.standard.bool(forKey: k_SOUND_ON)
            return soundOn
        }
        return true
    }
    
    func toggleSound(){
        let soundOn = isSoundOn()
        UserDefaults.standard.set(!soundOn, forKey: k_SOUND_ON)
    }
}
