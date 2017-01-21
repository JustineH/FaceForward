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
    let radio = RadioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestionsLabel.textColor = Styling.Colors.fontBody
        
        updateSuggestionsText()
        
        // Navigation button to go to survey again
        let assessmentButton = UIBarButtonItem(title: "Assessment", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goToSurveyVC))
        self.navigationItem.rightBarButtonItem = assessmentButton
        
        // Choose radio station based on largest emotion
        RadioPlayer.sharedInstance.chooseStation(emotion: emotionForSuggestion)
        
        // The info displayed on the control center music player
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            print("Receiving remote control events\n")
        } catch {
            print("Audio Session error.\n \(error.localizedDescription)")
            return
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.navigationController?.topViewController != self {
            RadioPlayer.sharedInstance.pause()
        }
    }
    
    /// Update the suggestions text, content changes according to the largest emotion
    func updateSuggestionsText() {
        suggestionsLabel.text = Suggestions.randomizeSuggestion(emotion: emotionForSuggestion)
    }
    
    
    // MARK: Buttons
    
    /// Toggle between play & pause
    @IBAction func playButtonPressed(_ sender: Any) {
        toggle()
    }
    
    /// Shuffle radio stations
    @IBAction func shuffleStation(_ sender: Any) {
        RadioPlayer.sharedInstance.shuffleStation()
    }
   
    /// Adjust volume
    @IBAction func volumeSlider(_ sender: UISlider) {
        RadioPlayer.sharedInstance.adjustVolume(value: sender.value)
    }

    
    // MARK: Radio Player
    
    /// Toggle between play & pause
    func toggle() {
        if RadioPlayer.sharedInstance.currentlyPlaying() {
            pauseRadio()
        } else {
            playRadio()
        }
    }
    
    /// Play radio
    func playRadio() {
        RadioPlayer.sharedInstance.play()
        playButton.setImage(#imageLiteral(resourceName: "PauseButton"), for: UIControlState.normal)
    }
    
    /// Pause radio
    func pauseRadio() {
        RadioPlayer.sharedInstance.pause()
        playButton.setImage(#imageLiteral(resourceName: "PlayButton"), for: UIControlState.normal)
    }
    
    /// Go to SurveyVC
    func goToSurveyVC() {
        presentingViewController?.dismiss(animated: true, completion: nil)
        _ = self.navigationController?.popToRootViewController(animated: true)
        
        RadioPlayer.sharedInstance.pause()
    }

}
