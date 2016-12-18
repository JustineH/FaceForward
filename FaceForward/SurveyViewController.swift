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
    @IBOutlet weak var sleepHoursLabel: UILabel!
    @IBOutlet weak var sleepSlider: UISlider!
    @IBOutlet weak var exerciseControl: UISegmentedControl!
    @IBOutlet weak var peopleTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var didExercise: Bool!
    var selectedMood: String!
    var sleepValue: Double!
    var pickerData: [String] = [String]()
    
    //MARK: Actions
    
    
    @IBAction func moodSlider(_ sender: Any) {
        let moodValue = moodSlider.value as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        
        let moodString = formatter.string(from:moodValue)!
        switch moodString {
        case "0":
            moodLabel.text = "angry"
        case "1":
            moodLabel.text = "sad"
        case "2":
            moodLabel.text = "content"
        case "3":
            moodLabel.text = "happy"
        case "4":
            moodLabel.text = "on top of the world!"
        default:
            break
        }
        selectedMood = moodLabel.text
    }
    
    @IBAction func nextButton(_ sender: Any) {
        let date = Date()
        let newMood = Survey()
        newMood.moodInput = selectedMood
        newMood.sleepInput = sleepValue
        newMood.exerciseInput = didExercise!
        newMood.peopleInput = peopleTextField.text ?? ""
        newMood.notesInput = notesTextField.text ?? ""
        
        print(newMood)
    }
    
    @IBAction func sleepSlider(_ sender: Any) {
        let sleepHours = sleepSlider.value as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        let svalue = formatter.string(from: sleepHours)
        sleepValue = formatter.number(from: svalue!) as Double!
        sleepHoursLabel.text = "I got \(sleepValue!) hrs of Sleep"

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
