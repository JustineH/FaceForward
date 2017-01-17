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
    let stations = RadioStations()
    let moodArray = ["Anger", "Contempt", "Happiness", "Sadness", "Disgust", "Fear", "Neutral", "Surprise"]
    
    /// chooses the radio station based on largest emotion
    func chooseStation(emotion: String) {
        let chosenStation = stations.changeStation(mood: emotion)
        player.replaceCurrentItem(with: chosenStation)
    }
    
    /// shuffles the radio station
    func shuffleStation() {
        let randomMood = Int(arc4random_uniform(UInt32(moodArray.count)))
        let currentStation = stations.changeStation(mood: moodArray[randomMood])
            player.replaceCurrentItem(with: currentStation)
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
