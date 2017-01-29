//
//  AnalysisChartViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import SwiftyJSON
import RealmSwift
import Charts

class AnalysisChartViewController: UIViewController, ChartViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var chartNextButton: UIButton!
    
    dynamic var emotionsToPassToPieChart = [String:Double]()
    dynamic var emotionsArray = [String]()
    var dict = Emotion()
   
    /// Go to SuggestionsVC
    @IBAction func nextToSuggestionsButton(_ sender: Any) {
        
        Router(self).showSuggestions(emotion: highestEmotion())
        
        self.navigationItem.hidesBackButton = true
       
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Styling.styleButton(button: chartNextButton)
        
        pieChartView.delegate = self
        pieChartView.notifyDataSetChanged()
        
        emotionsToPassToPieChart[EmotionName.happiness.rawValue] = dict.happiness
        emotionsToPassToPieChart[EmotionName.neutral.rawValue] = dict.neutral
        emotionsToPassToPieChart[EmotionName.surprise.rawValue] = dict.surprise
        emotionsToPassToPieChart[EmotionName.sadness.rawValue] = dict.sadness
        emotionsToPassToPieChart[EmotionName.fear.rawValue] = dict.fear
        emotionsToPassToPieChart[EmotionName.anger.rawValue] = dict.anger
        emotionsToPassToPieChart[EmotionName.contempt.rawValue] = dict.contempt
        emotionsToPassToPieChart[EmotionName.disgust.rawValue] = dict.disgust
        
        let emotionsPercentage = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        setChart(dataPoints: emotionsArray, values: emotionsPercentage)
        updateChartData()
        
    }
    
    /// Create an empty pie chart with a legend
    func setChart(dataPoints: [String], values: [Double]) {
        
        let legend = pieChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .center
        legend.drawInside = false
        legend.orientation = .vertical
        legend.font = NSUIFont.systemFont(ofSize: 14.5)
        
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = false
        pieChartView.legend.enabled = true
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.rotationEnabled = true
        pieChartView.highlightPerTapEnabled = false
        pieChartView.animate(xAxisDuration: 2.0)
        pieChartView.backgroundColor = UIColor.clear
        
    }
    
    /// Add data entries to pie chart
    func updateChartData() {
        
        var dataEntries: [PieChartDataEntry] = []
        
        for emotion in EmotionName.allNamesInOrder() {
            
            let emotionPercent = String(format: "%.2f", arguments: [emotionsToPassToPieChart[emotion]! *  100] )
            let dataEntry = PieChartDataEntry(value: emotionsToPassToPieChart[emotion]!, label: "\(emotion): \(emotionPercent)%")
            
            dataEntries.append(dataEntry)
    
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let data: PieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartDataSet.drawValuesEnabled = false
        pieChartView.data = data
 
        pieChartDataSet.colors = chartColors()
        
    }
    
    func chartColors() -> [UIColor] {
        
        var colors: [UIColor] = []
        
        let happinessEmotion = Styling.Colors.yellowColor
        let neutralEmotion = Styling.Colors.pinkColor
        let surpriseEmotion = Styling.Colors.purpleColor
        let sadnessEmotion = Styling.Colors.darkPurpleColor
        let fearEmotion = Styling.Colors.darkBlueColor
        let angerEmotion = Styling.Colors.brightPinkColor
        let contemptEmotion = Styling.Colors.orangeColor
        let disgustEmotion = Styling.Colors.redColor
      
        // If updating emotions in EmotionName file, these have to be added to the array in the same order
        colors.append(happinessEmotion)
        colors.append(neutralEmotion)
        colors.append(surpriseEmotion)
        colors.append(sadnessEmotion)
        colors.append(fearEmotion)
        colors.append(angerEmotion)
        colors.append(contemptEmotion)
        colors.append(disgustEmotion)
        
        return colors
    }
    
    /// Find emotion with highest value to pass to SuggestionsVC
    func highestEmotion() -> String {
        
        var highestKey = ""
        var highestValue = 0.0
        
        for emotion in emotionsToPassToPieChart.keys {
            if (emotionsToPassToPieChart[emotion]! > highestValue) {
                highestValue = emotionsToPassToPieChart[emotion]!
                highestKey = emotion
            }
        }
        
        return highestKey
    }

}

