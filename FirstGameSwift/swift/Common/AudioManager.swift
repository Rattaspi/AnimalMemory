//
//  AudioManager.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 11/04/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import AVFoundation

class AudioController {
    let player = AVPlayer(url: Bundle.main.url(forResource: "NOMBRE DEL ARCHIVO EN EL PROYECTO.mp3", withExtension: nil)!)
    
    private static let sharedAudioController = AudioController()
    
    static var shared: AudioController {
        return sharedAudioController
    }
    
    func play(){
        player.play()
    }
    
    func pause(){
        player.pause()
    }
    
    func stop(){
        player.pause()
        player.seek(to: CMTime.zero)
    }
    
    func on() {
        player.volume = 1.0
    }
}
