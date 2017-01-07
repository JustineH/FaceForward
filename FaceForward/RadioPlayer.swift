//
//  RadioPlayer.swift
//  FaceForward
//
//  Created by carmen cheng on 2017-01-06.
//
//

import Foundation
import AVFoundation

class RadioPlayer {
    
    static let sharedInstance = RadioPlayer()
    private var player = AVPlayer()
    private var isPlaying = false
    let radi = RadioStations()
    
    func chooseStation(emotion: Emotion) {
        let chosenStation = radi.changeStation(mood: emotion.largestEmotion)
        player.replaceCurrentItem(with: chosenStation)
    }
    
    func play() {
        player.play()
        isPlaying = true
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying == true {
            pause()
        } else {
            play()
        }
    }
    
    func adjustVolume(value: Float) {
        player.volume = value
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
}
