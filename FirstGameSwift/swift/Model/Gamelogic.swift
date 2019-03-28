//
//  Gamelogic.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 21/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

class Gamelogic {
    enum Level: Int {case easy = 8, medium = 16, hard = 30};
    
    var cards = [Card]()
    var points = 0
    var selectedCard: Card?
    var level: Level?
    let cardSufx: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
    
    func start(level: Level){
        self.level = level
        
        //CREATE THE CARDS
        let _cardSufx = cardSufx.shuffled()
        for i in 0..<level.rawValue/2{
            cards.append(Card(id: i*2, textureFront: "animal_\( _cardSufx[i])", textureBack: "cardB", state: Card.State.covered))
            cards.append(Card(id: i*2+1, textureFront: "animal_\( _cardSufx[i])", textureBack: "cardB", state: Card.State.covered))
        }
        
        /* //DEBUG
        for card in cards{
            print("\(card.id) \(card.textF)")
        }
        */
    }
    
    //MAYBE I'LL NEED IT LATER
    /*
    func startEasy(){
        
    }
    func startMedium(){
        
    }
    func startHard(){
        
    }
    */
}
