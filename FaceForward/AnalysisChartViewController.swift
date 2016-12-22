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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.delegate = self
        
        let emotionsArray = ["Anger", "Contempt", "Happiness", "Disgust", "Sadness", "Surprise", "Fear", "Neutral"]
        let emotionsPercentage = [0.0]
        
        setChart(dataPoints: emotionsArray, values: emotionsPercentage)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i])
            dataEntries.append(dataEntry)
        }
        
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Emotions")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.animate(xAxisDuration: 1.0)
        
        pieChartView.xAxis.labelPosition = .bothSided
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
