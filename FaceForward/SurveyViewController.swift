//
//  SurveyViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit

class SurveyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Properties
    @IBOutlet weak var moodPicker: UIPickerView!
    
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
    
    @IBAction func nextButton(_ sender: Any) {
        let newMood = Emotion()
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
        sleepHoursLabel.text = "\(sleepValue!) h"

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
        self.moodPicker.delegate = self
        self.moodPicker.dataSource = self
        pickerData = ["Happy", "Surprised", "Sad", "Angry"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Picker Stuffs
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMood = pickerData[row] as String
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
