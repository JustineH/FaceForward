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
    
    var didExercise: Bool!
    var selectedMood: String!
    var selectedSleep: String!
    var pickerData: [String] = [String]()
    
    //MARK: Actions
    
    
    @IBAction func moodSlider(_ sender: Any) {
        let moodValue = moodSlider.value as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        
        let moodString = formatter.string(from:moodValue)!
        switch moodString {
            case "0":
                moodLabel.text = "Great"
            case "1":
                moodLabel.text = "Good"
            case "2":
                moodLabel.text = "Average"
            case "3":
                moodLabel.text = "Bad"
            case "4":
                moodLabel.text = "Very bad"
            default:
                break
        }
        selectedMood = moodLabel.text
    }
    
    @IBAction func nextButton(_ sender: Any) {
        let date = Date()
        let newMood = Survey()
        newMood.moodInput = selectedMood
        newMood.sleepInput = selectedSleep
        newMood.exerciseInput = didExercise!
        newMood.peopleInput = peopleTextField.text ?? ""
        
        print(newMood)
    }
    
    @IBAction func sleepSlider(_ sender: Any) {
        let sleepQuality = sleepSlider.value as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        
        let sleepString = formatter.string(from: sleepQuality)!
        switch sleepString {
            case "0":
                sleepQualityLabel.text = "Great"
            case "1":
                sleepQualityLabel.text = "Well"
            case "2":
                sleepQualityLabel.text = "Average"
            case "3":
                sleepQualityLabel.text = "Poorly"
            case "4":
                sleepQualityLabel.text = "Very poorly"
            default:
                break
        }
        selectedSleep = sleepQualityLabel.text
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
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
