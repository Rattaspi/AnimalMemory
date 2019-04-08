//
//  GameInfo.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 4/4/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import CoreGraphics

class GameInfo {
    static let fontName: String = "TimKid"
    
    static let timeBonusMultiplier = 50
    static let pointsPerCard = 100
    
    class Easy: GameInfo {
        let initialPos = CGPoint(x: 0.20, y: 0.4)
        let offset = CGPoint(x: 0.20, y: 0.16)
        let row = 2
        let column = 4
    }
    
    class Medium: GameInfo {
        let initialPos = CGPoint(x: 0.20, y: 0.2)
        let offset = CGPoint(x: 0.20, y: 0.16)
        let row = 4
        let column = 4
    }
    
    class Hard: GameInfo {
        let initialPos = CGPoint(x: 0.15, y: 0.12)
        let offset = CGPoint(x: 0.164, y: 0.14)
        let row = 6
        let column = 5
    }
}
