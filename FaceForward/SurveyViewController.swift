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
    @IBOutlet weak var moodPicker: UIPickerView!
    
    @IBOutlet weak var sleepHoursLabel: UILabel!
    @IBOutlet weak var sleepSlider: UISlider!
    @IBOutlet weak var exerciseControl: UISegmentedControl!
    @IBOutlet weak var peopleTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
