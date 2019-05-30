//
//  GameInfo.swift
//  FirstGameSwift
//
//  Created by ENTIPRO on 4/4/19.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import CoreGraphics


class GameInfo {
    static var dbId: String = ""
    
    static let fontName: String = "TimKid"
    static let bgName: String = "MainMenu_bg"
    static let bgBlurName: String = "blur_bg"
    
    static let timeBonusMultiplier = 50
    static let pointsPerCard = 100
    
    var initialPos: CGPoint!
    var offset: CGPoint!
    var row: Int!
    var column: Int!
    var cWidth: Int!
    var cHeight: Int!
    
    init(){}
}

class Easy: GameInfo {
    override init (){
        super.init()
        initialPos = CGPoint(x: 0.20, y: 0.4)
        offset = CGPoint(x: 0.20, y: 0.16)
        row = 2
        column = 4
        cWidth = 70
        cHeight = 84
    }
}

class Medium: GameInfo {
    override init(){
        super.init()
        initialPos = CGPoint(x: 0.20, y: 0.2)
        offset = CGPoint(x: 0.20, y: 0.16)
        row = 4
        column = 4
        cWidth = 70
        cHeight = 84
    }
}

class Hard: GameInfo {
    override init(){
        super.init()
        initialPos = CGPoint(x: 0.15, y: 0.12)
        offset = CGPoint(x: 0.164, y: 0.14)
        row = 6
        column = 5
        cWidth = 60
        cHeight = 72
    }
}
