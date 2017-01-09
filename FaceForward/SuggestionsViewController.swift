//
//  SuggestionsViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit

class SuggestionsViewController: UIViewController {
    
    @IBOutlet weak var suggestionsLabel: UITextView!
    @IBOutlet weak var radioStationNameLabel: UIButton!
    @IBOutlet weak var chooseOwnStationLabel: UIButton!
    @IBOutlet weak var musicNote: UIImageView!
    
    var emotionForSuggestion: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSuggestionsText()
        radioStationNameLabel.backgroundColor = Styling.Colors.purpleColor
        chooseOwnStationLabel.backgroundColor = Styling.Colors.yellowColor
        radioStationNameLabel.tintColor = Styling.Colors.darkBlueColor
        chooseOwnStationLabel.tintColor = Styling.Colors.darkBlueColor

        // Do any additional setup after loading the view.
    }
    
    func updateSuggestionsText() {
        suggestionsLabel.text = Suggestions.randomizeSuggestion(emotion: emotionForSuggestion)
    }
    
    
    @IBAction func randomRadioStationButton(_ sender: Any) {
    }
    

    @IBAction func chooseOwnStationButton(_ sender: Any) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
