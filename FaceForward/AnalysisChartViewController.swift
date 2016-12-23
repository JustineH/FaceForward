//
//  AnalysisChartViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import Charts

class AnalysisChartViewController: UIViewController, ChartViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    dynamic var emotionsArray: [String]!
    var dict: Emotion?
    
    
    @IBAction func nextToSuggestionsButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.delegate = self
        
        let emotionsArray = ["Anger", "Contempt", "Disgust", "Fear", "Sadness", "Surprise", "Happiness", "Neutral"]
        let emotionsPercentage = [0.0]
        
        setChart(dataPoints: emotionsArray, values: emotionsPercentage)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        var emotionsToPassToPieChart = [String:Double]()
        emotionsToPassToPieChart["Anger"] = dict!.anger
        emotionsToPassToPieChart["Contempt"] = dict!.contempt
        emotionsToPassToPieChart["Disgust"] = dict!.disgust
        emotionsToPassToPieChart["Fear"] = dict!.fear
        emotionsToPassToPieChart["Sadness"] = dict!.sadness
        emotionsToPassToPieChart["Surprise"] = dict!.surprise
        emotionsToPassToPieChart["Happiness"] = dict!.happiness
        emotionsToPassToPieChart["Neutral"] = dict!.neutral
       
        for (emotion, percentage) in emotionsToPassToPieChart {
            let dataEntry = PieChartDataEntry(value: percentage, label: emotion)
            dataEntries.append(dataEntry)
        }
    
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Emotions")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.animate(xAxisDuration: 1.0)
        
      //  pieChartView.yAxis.labelPosition = .bothSided
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
