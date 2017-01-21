//
//  SurveyViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit

class SurveyViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var moodSlider: UISlider!
    @IBOutlet weak var sleepQualityLabel: UILabel!
    @IBOutlet weak var sleepSlider: UISlider!
    @IBOutlet weak var exerciseControl: UISegmentedControl!
    @IBOutlet weak var peopleTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var scrolly: UIScrollView!
    
    
    var didExercise: Bool = false
    var selectedMood: String!
    var selectedSleep: String!
    var pickerData: [String] = [String]()
    var mood: Mood = Mood.average
    var sleep: Sleep = Sleep.average
    
    //MARK: Actions
    
    /// (tap guesture recongnizer) tap to dismiss keyboard
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        keyboardDismiss()
    }
    
    /// slider for mood
    @IBAction func moodSlider(_ sender: Any) {
        let moodValue = Int(moodSlider.value)
        
        switch moodValue {
            case 0:
                mood = Mood.veryBad
            case 1:
                mood = Mood.bad
            case 2:
                mood = Mood.average
            case 3:
                mood = Mood.good
            case 4:
                mood = Mood.great
            default:
                break
        }
        moodLabel.text = mood.rawValue
    }
    
    /// creates a survey item for realm (not saved yet) and goes to photoVC
    @IBAction func nextButton(_ sender: Any) {
        let newSurvey = Survey()
        newSurvey.moodInput = mood.rawValue
        newSurvey.sleepInput = sleep.rawValue
        newSurvey.exerciseInput = didExercise
        newSurvey.peopleInput = peopleTextField.text ?? ""
        Router(self).showPhoto(survey: newSurvey)
    }
    
    /// slider for sleep
    @IBAction func sleepSlider(_ sender: Any) {
        let sleepQuality = Int(sleepSlider.value)
        
        switch sleepQuality {
            case 0:
                sleep = Sleep.veryPoorly
            case 1:
                sleep = Sleep.poorly
            case 2:
                sleep = Sleep.average
            case 3:
                sleep = Sleep.well
            case 4:
                sleep = Sleep.great
            default:
                break
        }
        sleepQualityLabel.text = sleep.rawValue
    }
    
    /// exercise y/n
    @IBAction func exerciseControl(_ sender: Any) {
        if exerciseControl.selectedSegmentIndex == 0 {
            didExercise = true
        }else if exerciseControl.selectedSegmentIndex == 1 {
            didExercise = false
        }
    }
    
    /// (people textfield) tap to dismiss??
    @IBAction func viewTapped(_ sender: AnyObject) {
        keyboardDismiss()
    }
    
    //MARK: View
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.reset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let image = UIImage(named: "FaceForward_Logo5")
//        navigationItem.titleView = UIImageView(image: image)
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
        RadioPlayer.sharedInstance.pause()
        Styling.styleButton(button: nextButton)
        self.peopleTextField.delegate = self;
        peopleTextField.textColor = Styling.Colors.fontBody
        peopleTextField.backgroundColor = Styling.Colors.textFieldColor
//        peopleTextField.textColor = UIColor(red: 46.0/255.0, green: 48.0/255.0, blue: 47.0/255.0, alpha: 1.0)
//        peopleTextField.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// resize view for keyboard space on screen
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
                self.view.frame.size.height -= (keyboardSize.height - 49)
//            }
        }
    }
    
    /// resize view for no keyboard
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0 {
                self.view.frame.size.height += (keyboardSize.height - 49)
//            }
        }
    }
    
    /// dismiss the keyboard
    func keyboardDismiss() {
        peopleTextField.resignFirstResponder()
    }
    
    /// press enter to dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardDismiss()
        return true
    }
    
    /// tap to end text editing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// set everything to default value
    func reset() {
        self.moodSlider.setValue(2.0, animated: false)
        self.moodLabel.text = "Average"
        self.sleepSlider.setValue(2.0, animated: false)
        self.sleepQualityLabel.text = "Average"
        self.exerciseControl.selectedSegmentIndex = 1
        self.peopleTextField.text = ""
        scrolly.scrollToTop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIScrollView {
    
    /// scrolls to top of scroll view
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
