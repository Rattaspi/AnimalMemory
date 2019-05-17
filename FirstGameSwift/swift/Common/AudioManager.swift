//
//  AudioManager.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 11/04/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import AVFoundation

class AudioManager: NSObject {
    static var globalSoundOn: Bool?
    
    let player = AVPlayer(url: Bundle.main.url(forResource: "background_music.mp3", withExtension: nil)!)
    
    var looper: AVPlayerLooper!
    var queue: AVQueuePlayer!
    var playing = false
    let volume: Float = 0.7
    let songName = "background_music.mp3"
    
    private static let sharedAudioController = AudioManager()
    
    static var shared: AudioManager {
        return sharedAudioController
    }
    
    override init() {
        let playerItem = AVPlayerItem(url: Bundle.main.url(forResource: songName, withExtension: nil)!)
        queue = AVQueuePlayer(playerItem: playerItem)
        looper = AVPlayerLooper(player: queue, templateItem: playerItem)
    }
    
    func play(){
        if(!playing){
            queue.pause()
            queue.removeAllItems()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                let playerItem = AVPlayerItem(url: Bundle.main.url(forResource: self.songName, withExtension: nil)!)
                self.queue.insert(playerItem, after: nil)
                self.looper = AVPlayerLooper(player: self.queue, templateItem: playerItem)
                self.queue.play()
                
                if(AudioManager.globalSoundOn!){
                    self.queue.volume = self.volume
                    self.playing = true
                }
                else {
                    self.queue.volume = 0.0
                }
            }
        }
    }
    
    func pause(){
        player.pause()
    }
    
    func stop(){
        player.pause()
        player.seek(to: CMTime.zero)
    }
    
    func on() {
        queue.volume = volume
    }
    
    func off() {
        queue.volume = 0.0
    }
}
