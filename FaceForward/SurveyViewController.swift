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
    
    /// Tap gesture recognizer to dismiss keyboard
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        keyboardDismiss()
    }
    
    /// Slider for mood
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
    
    /// Create a survey item for Realm (not saved yet) and go to PhotoVC
    @IBAction func nextButton(_ sender: Any) {
        let newSurvey = Survey()
        newSurvey.moodInput = mood.rawValue
        newSurvey.sleepInput = sleep.rawValue
        newSurvey.exerciseInput = didExercise
        newSurvey.peopleInput = peopleTextField.text ?? ""
        Router(self).showPhoto(survey: newSurvey)
    }
    
    /// Slider for sleep
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
    
    /// Exercise Yes/No
    @IBAction func exerciseControl(_ sender: Any) {
        if exerciseControl.selectedSegmentIndex == 0 {
            didExercise = true
        }else if exerciseControl.selectedSegmentIndex == 1 {
            didExercise = false
        }
    }
    
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
        
        RadioPlayer.sharedInstance.pause()
        Styling.styleButton(button: nextButton)
        self.peopleTextField.delegate = self;
        self.peopleTextField.textColor = Styling.Colors.fontBody
        self.peopleTextField.backgroundColor = Styling.Colors.textFieldColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Resize view for keyboard space on screen
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            // Can't get keyboard size
            return
        }
        
        guard let navBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height else {
            // Can't get the nav bar height
            return
        }
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
//        let tabBarHeight: CGFloat = (UIScreen.main.bounds.height - self.view.frame.size.height)/2.0
        let scrollViewHeight: CGFloat = 830 // This should not be hard coded
        let padding: CGFloat = 20
        let animationDuration: TimeInterval = 0.25
        let textFieldOffset = scrollViewHeight - self.peopleTextField.frame.maxY
        
        // Wait until the view's frame has changed before changing the offset of the scrollview. If you change the offset while the view is changing, the final offset will be wrong
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            // Gets called after the the view's frame has been changed
            let yOffset = scrollViewHeight - self.view.frame.size.height + navBarHeight + statusBarHeight - textFieldOffset + padding
            if yOffset > 0 {
                UIView.animate(withDuration: animationDuration, animations: {
                    self.scrolly.contentOffset = CGPoint(x: 0, y: yOffset)
                })
            }
        })
        
        self.view.frame.size.height -= (keyboardSize.height)
        
        CATransaction.commit()
    }
    
    /// Resize view when no keyboard used
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.size.height += (keyboardSize.height)
        }
    }
    
    /// Dismiss keyboard
    func keyboardDismiss() {
        peopleTextField.resignFirstResponder()
    }
    
    /// Press Return/Enter to dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardDismiss()
        return true
    }
    
    /// Tap to end text editing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// Set everything to default value
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
    
    /// Scroll to top of scroll view
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
