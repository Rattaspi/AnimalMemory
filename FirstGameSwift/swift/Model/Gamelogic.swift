//
//  Gamelogic.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 21/03/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import SpriteKit

class Gamelogic: CardBehavior {
   
    enum Level: Int {case easy = 8, medium = 16, hard = 30};
    
    var cards = [Card]()
    var level: Level?
    let cardSufx: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
    
    //IN GAME VARIABLES
    var revealedCard: CardSprite?
    
    var goal: Int? //The matches you need to win the game
    var currentMatches: Int = 0 //How many matches have you made in the current level
    var currentStreak: Int = 0
    
    var maxTime: Int = -1
    var initialTime: CGFloat = -1
    var currentGameTime: CGFloat = 0
    var bonusTime: Int = -1 //This is te value that is printed in the screen
    
    //Scores to display in the gameover scene
    var matchStreak = 0
    var points = 0
    var bonusScore = 0
    var attempts = 0
    
    var win = false
    
    func start(level: Level){
        self.level = level
        self.currentMatches = 0
        self.points = 0
        //CREATE THE CARDS
        let _cardSufx = cardSufx.shuffled()
        for i in 0..<level.rawValue/2{
            cards.append(Card(id: i*2, textureFront: "animal_\( _cardSufx[i])", textureBack: "cardB", state: Card.State.covered))
            cards.append(Card(id: i*2+1, textureFront: "animal_\( _cardSufx[i])", textureBack: "cardB", state: Card.State.covered))
        }
        
        goal = level.rawValue/2
    }
    
    func update(_ currentTime: TimeInterval){
        //Calculate the current time
        if(initialTime < 0){
            initialTime = CGFloat(currentTime)
        }
        currentGameTime = floor(CGFloat(currentTime) - initialTime)
        bonusTime = maxTime - Int(currentGameTime) < 0 ? 0 : maxTime - Int(currentGameTime)
        
        //Check the win condition
        self.win = checkWin()
    }
    
    func checkWin() -> Bool {
        if let goal = self.goal {
            let win = self.currentMatches >= goal
            bonusScore = bonusTime * GameInfo.timeBonusMultiplier
            return win
        }
        else{
         return false
        }
    }
    
    //when a card is flipped this method is called
    func cardFlipped(card: CardSprite) {
        let revealAudio = SKAction.sequence([SKAction.playSoundFileNamed("sfx_flip3", waitForCompletion: false)])
        card.run(revealAudio)
        if(revealedCard == nil){
            revealedCard = card
        }
        else {
            //Match found
            if(revealedCard?.card?.textF == card.card?.textF){
                revealedCard?.card?.state = .matched
                card.card?.state = .matched
                self.currentMatches += 1
                self.currentStreak += 1
                self.points += GameInfo.pointsPerCard * self.currentStreak
                let matchSfx = SKAction.sequence([SKAction.playSoundFileNamed("sfx_match.wav", waitForCompletion: false)])
                card.run(matchSfx)
                
                if(checkWin()){
                    self.matchStreak = self.matchStreak < self.currentStreak ? self.currentStreak : self.matchStreak
                }
                
                revealedCard?.isUserInteractionEnabled = false
                card.isUserInteractionEnabled = false
            }
            else {
                self.revealedCard?.flip()
                card.flip()
                self.matchStreak = self.matchStreak < self.currentStreak ? self.currentStreak : self.matchStreak
                self.currentStreak = 0
                let audioSeq = SKAction.sequence([SKAction.playSoundFileNamed("sfx_error", waitForCompletion: false)])
                card.run(audioSeq)
            }
            revealedCard = nil
            attempts += 1
        }
    }
}
