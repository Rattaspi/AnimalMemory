//
//  Gamelogic.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 21/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

//SKAudioNode
//SKAction.playSoundFileNamed(<#T##soundFile: String##String#>, waitForCompletion: <#T##Bool#>)

class Gamelogic: CardBehavior {
   
    
    enum Level: Int {case easy = 8, medium = 16, hard = 30};
    
    var cards = [Card]()
    var level: Level?
    let cardSufx: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
    
    //IN GAME VARIABLES
    var revealedCard: CardSprite?
    var points = 0
    var goal: Int? //The matches you need to win the game
    var currentMatches: Int? //How many matches have you made in the current level
    
    func start(level: Level){
        self.level = level
        self.currentMatches = 0
        //CREATE THE CARDS
        let _cardSufx = cardSufx.shuffled()
        for i in 0..<level.rawValue/2{
            cards.append(Card(id: i*2, textureFront: "animal_\( _cardSufx[i])", textureBack: "cardB", state: Card.State.covered))
            cards.append(Card(id: i*2+1, textureFront: "animal_\( _cardSufx[i])", textureBack: "cardB", state: Card.State.covered))
        }
        
        goal = level.rawValue/2
    }
    
    func checkWin() -> Bool {
        if let currentMatches = self.currentMatches, let goal = self.goal {
            let win = currentMatches >= goal
            return win
        }
        else{
         return false
        }
    }
    
    
    //TODO: move the card flip to the scene, gamelogic only has to check if there is a match
    //when a card is flipped this method is called
    func cardFlipped(card: CardSprite) {
        if(revealedCard == nil){
            revealedCard = card
        }
        else {
            //Match found
            if(revealedCard?.card?.textF == card.card?.textF){
                revealedCard?.card?.state = .matched
                card.card?.state = .matched
                self.currentMatches? += 1
                
                revealedCard?.isUserInteractionEnabled = false
                card.isUserInteractionEnabled = false
            }
            else {
                /*
                let sequence = SKAction.sequence([
                    SKAction.wait(forDuration: 0.5),
                    SKAction.run {
                        self.revealedCard?.flip()
                        card.flip()
                    }
                    ])
                card.run(sequence)
                */
                self.revealedCard?.flip()
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
