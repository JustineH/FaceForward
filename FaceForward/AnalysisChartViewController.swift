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
    
    dynamic var emotionsToPassToPieChart = [String:Double]()
    dynamic var emotionsArray = [String]()
    var dict = Emotion()
    
    
    @IBAction func nextToSuggestionsButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.delegate = self
        pieChartView.notifyDataSetChanged()
        
        emotionsToPassToPieChart["Anger"] = dict.anger
        emotionsToPassToPieChart["Contempt"] = dict.contempt
        emotionsToPassToPieChart["Disgust"] = dict.disgust
        emotionsToPassToPieChart["Fear"] = dict.fear
        emotionsToPassToPieChart["Sadness"] = dict.sadness
        emotionsToPassToPieChart["Surprise"] = dict.surprise
        emotionsToPassToPieChart["Happiness"] = dict.happiness
        emotionsToPassToPieChart["Neutral"] = dict.neutral

    //    emotionsArray = emotionsToPassToPieChart.keys
        
        let emotionsPercentage = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        setChart(dataPoints: emotionsArray, values: emotionsPercentage)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        let legend = pieChartView.legend as Legend
        legend.enabled = true
        legend.horizontalAlignment = .left
        legend.drawInside = false
        legend.orientation = .horizontal
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = false
        pieChartView.legend.enabled = true
        pieChartView.rotationEnabled = false
        pieChartView.highlightPerTapEnabled = false
        
        var dataEntries: [PieChartDataEntry] = []
        
       
        for emotion in emotionsToPassToPieChart.keys {
 
            let dataEntry = PieChartDataEntry(value: emotionsToPassToPieChart[emotion]!, label: emotion)
          //  let dataEntry = PieChartDataEntry(value: percentage, label: emotion)
           // let emotion = formatter.stringFromArray(emotion)
            
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChartView.data = pieChartData
        pieChartView.notifyDataSetChanged()
        pieChartView.animate(xAxisDuration: 2.0)
        
      //  pieChartView.setNeedsDisplay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
