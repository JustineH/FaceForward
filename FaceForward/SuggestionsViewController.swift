//
//  SuggestionsViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import AVFoundation
import MediaPlayer

class SuggestionsViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var suggestionsLabel: UITextView!
    @IBOutlet weak var shoutCastLogo: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var shuffleButton: UIButton!
    
    var emotionForSuggestion: String!
//    let passedEmotion = Emotion()
    let radio = RadioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestionsLabel.textColor = Styling.Colors.fontBody
        
        
        updateSuggestionsText()

        RadioPlayer.sharedInstance.chooseStation(emotion: emotionForSuggestion)
        
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            print("Receiving remote control events\n")
        } catch {
            print("Audio Session error.\n \(error.localizedDescription)")
            return
        }
        
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            
            let image:UIImage = UIImage(named: "FaceForward_Logo5")! // comment this if you don't use an image
            let songInfo = [
                MPMediaItemPropertyTitle: "via FaceForward App",
                MPMediaItemPropertyArtist: "streaming from SHOUTcast"
                ] as [String : Any]
            MPNowPlayingInfoCenter.default().nowPlayingInfo = songInfo
        }

    }
    
    func updateSuggestionsText() {
        suggestionsLabel.text = Suggestions.randomizeSuggestion(emotion: emotionForSuggestion)
    }
    
    
    // MARK: Buttons
    
    @IBAction func playButtonPressed(_ sender: Any) {
        toggle()
    }
    
    @IBAction func shuffleStation(_ sender: Any) {
        RadioPlayer.sharedInstance.shuffleStation()
    }
   
    @IBAction func volumeSlider(_ sender: UISlider) {
        RadioPlayer.sharedInstance.adjustVolume(value: sender.value)
    }

    
    // MARK: Radio Player
    
    func toggle() {
        if RadioPlayer.sharedInstance.currentlyPlaying() {
            pauseRadio()
        } else {
            playRadio()
        }
    }
    
    func playRadio() {
        RadioPlayer.sharedInstance.play()
        playButton.setImage(#imageLiteral(resourceName: "PauseButton"), for: UIControlState.normal)
    }
    
    func pauseRadio() {
        RadioPlayer.sharedInstance.pause()
        playButton.setImage(#imageLiteral(resourceName: "PlayButton"), for: UIControlState.normal)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
