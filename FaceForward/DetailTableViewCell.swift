//
//  DetailTableViewCell.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-22.
//
//

import UIKit
import RealmSwift

class DetailTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var emotionLabel: UILabel!
    
    let myDateFormatter = MyDateFormatter()
    
    //MARK: Everything else
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateLabel.textColor = Styling.Colors.fontBody
        emotionLabel.textColor = Styling.Colors.fontBody
        moodLabel.textColor = Styling.Colors.fontBody
        sleepLabel.textColor = Styling.Colors.fontBody
        exerciseLabel.textColor = Styling.Colors.fontBody
        peopleLabel.textColor = Styling.Colors.fontBody
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Configure Cell View
    func configureCell(moods:DataEntry) {
        
        if moods.survey[0].exerciseInput == true {
            self.exerciseLabel.text = "Yes"
        }else if moods.survey[0].exerciseInput == false {
            self.exerciseLabel.text = "No"
        }else {
            self.exerciseLabel.text = ""
        }
        
        let dateHeader = myDateFormatter.configureDate(date: moods.date)
        
        self.dateLabel.text = "\(dateHeader)"
        self.emotionLabel.text = moods.emotion[0].largestEmotion.capitalized
        self.moodLabel.text = moods.survey[0].moodInput ?? ""
        self.sleepLabel.text = moods.survey[0].sleepInput ?? ""
        self.peopleLabel.text = moods.survey[0].peopleInput ?? "-  "
    }

}
