//
//  Gamelogic.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 21/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

class Gamelogic: CardBehavior {
   
    
    enum Level: Int {case easy = 8, medium = 16, hard = 30};
    
    var cards = [Card]()
    var level: Level?
    let cardSufx: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
    
    //IN GAME VARIABLES
    var revealedCard: CardSprite?
    var points = 0
    var goal: Int? //The matches you need to win the game
    
    func start(level: Level){
        self.level = level
        
        //CREATE THE CARDS
        let _cardSufx = cardSufx.shuffled()
        for i in 0..<level.rawValue/2{
            cards.append(Card(id: i*2, textureFront: "animal_\( _cardSufx[i])", textureBack: "cardB", state: Card.State.covered))
            cards.append(Card(id: i*2+1, textureFront: "animal_\( _cardSufx[i])", textureBack: "cardB", state: Card.State.covered))
        }
        
        goal = level.rawValue/2
        /* //DEBUG
        for card in cards{
            print("\(card.id) \(card.textF)")
        }
        */
    }
    
    //when a card is flipped this method is called
    func cardFlipped(card: CardSprite) {
        //TODO
        if(revealedCard == nil){
            revealedCard = card
        }
        else {
            if(revealedCard?.card?.textF == card.card?.textF){
                revealedCard?.card?.state = .matched
                card.card?.state = .matched
            }
            else {
                revealedCard?.flip()
                card.flip()
            }
            revealedCard = nil
        }
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
