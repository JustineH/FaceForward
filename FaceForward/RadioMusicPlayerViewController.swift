//
//  RadioMusicPlayerViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2017-01-06.
//
//

import UIKit
import AVFoundation
import MediaPlayer

class RadioMusicPlayerViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var playButton: UIButton!
    let passedEmotion = Emotion()
    let radio = RadioPlayer()
    
    //MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
    
        radio.chooseStation(emotion: passedEmotion)

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            print("Receiving remote control events\n")
        } catch {
            print("Audio Session error.\n")
            return
        }
        
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            let image:UIImage = UIImage(named: "FaceForward_Logo5")! // comment this if you don't use an image
            let albumArt = MPMediaItemArtwork(image: image)// comment this if you don't use an image
            let songInfo = [
                MPMediaItemPropertyTitle: "via FaceForward App",
                MPMediaItemPropertyArtist: "streaming from SHOUTcast",
                MPMediaItemPropertyArtwork: albumArt // comment this if you don't use an image
            ] as [String : Any]
            MPNowPlayingInfoCenter.default().nowPlayingInfo = songInfo
        }
        
    }
    
    //MARK: Buttons
    @IBAction func playButtonPressed(_ sender: Any) {
        toggle()
    }
    
    @IBAction func volumeSlider(_ sender: UISlider) {
        RadioPlayer.sharedInstance.adjustVolume(value: sender.value)
    }

    
    //MARK: Radio Player
    func toggle() {
        if RadioPlayer.sharedInstance.currentlyPlaying() {
            pauseRadio()
        } else {
            playRadio()
        }
    }
    
    func playRadio() {
        RadioPlayer.sharedInstance.play()
        playButton.setTitle("Pause", for: UIControlState.normal)
    }
    
    func pauseRadio() {
        RadioPlayer.sharedInstance.pause()
        playButton.setTitle("Play", for: UIControlState.normal)
    }
    



}
