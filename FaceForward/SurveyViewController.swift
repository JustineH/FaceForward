//
//  SurveyViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit

class SurveyViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var moodSlider: UISlider!
    @IBOutlet weak var sleepQualityLabel: UILabel!
    @IBOutlet weak var sleepSlider: UISlider!
    @IBOutlet weak var exerciseControl: UISegmentedControl!
    @IBOutlet weak var peopleTextField: UITextField!
  
    @IBOutlet weak var nextButton: UIButton!
    
    var didExercise: Bool = false
    var selectedMood: String!
    var selectedSleep: String!
    var pickerData: [String] = [String]()
    var mood: Mood = Mood.average
    var sleep: Sleep = Sleep.average
    
    //MARK: Actions
    @IBAction func moodSlider(_ sender: Any) {
        let moodValue = Int(moodSlider.value)
        
        switch moodValue {
            case 0:
                mood = Mood.great
            case 1:
                mood = Mood.good
            case 2:
                mood = Mood.average
            case 3:
                mood = Mood.bad
            case 4:
                mood = Mood.veryBad
            default:
                break
        }
        moodLabel.text = mood.rawValue
    }
    
    @IBAction func nextButton(_ sender: Any) {
        let newSurvey = Survey()
        newSurvey.moodInput = mood.rawValue
//        newSurvey.sleepInput = Sleep(rawValue: sleep.rawValue)
        newSurvey.exerciseInput = didExercise
        newSurvey.peopleInput = peopleTextField.text ?? ""
        print(newSurvey)
        Router(self).showPhoto(survey: newSurvey)
    }
    
    @IBAction func sleepSlider(_ sender: Any) {
        let sleepQuality = Int(sleepSlider.value)
        
        switch sleepQuality {
            case 0:
                sleep = Sleep.great
            case 1:
                sleep = Sleep.well
            case 2:
                sleep = Sleep.average
            case 3:
                sleep = Sleep.poorly
            case 4:
                sleep = Sleep.veryPoorly
            default:
                break
        }
        sleepQualityLabel.text = sleep.rawValue
    }
    
    @IBAction func exerciseControl(_ sender: Any) {
        if exerciseControl.selectedSegmentIndex == 0 {
            didExercise = true
        }else if exerciseControl.selectedSegmentIndex == 1 {
            didExercise = false
        }
    }
    
    
    
    //MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
