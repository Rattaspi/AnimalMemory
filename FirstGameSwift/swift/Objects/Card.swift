//
//  Card.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 21/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

class Card {
    var id: Int
    var textF: String
    var textB: String
    var state: State
    
    enum State {case covered,discovered,matched}
    
    init(id: Int, textureFront: String, textureBack: String, state: State) {
        self.id = id
        self.textF = textureFront
        self.textB = textureBack
        self.state = state
    }
}
