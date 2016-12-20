//
//  DetailLogViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import RealmSwift

class DetailLogViewController: UIViewController {
    
//MARK: Properties
    @IBOutlet weak var titleDateLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
//MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateLabels()
    }
    
//MARK: Labels
//    func updateLabels() {
//        titleDateLabel.text = "On \(date) you were..."
//        moodLabel.text =
//        exerciseLabel.text =
//        sleepLabel.text =
//        peopleLabel.text =
//        notesTextView.text =
//    }
}
