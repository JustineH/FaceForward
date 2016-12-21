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
        
        
    
//        self.pieChartView.data?.getDataSetByIndex(0).colors[0] = UIColor.Styling.PieChartAnalysis.redAnger
//        self.pieChartView.data?.getDataSetByIndex(1).colors[1] = UIColor.Styling.PieChartAnalysis.orangeContempt
//        self.pieChartView.data?.getDataSetByIndex(2).colors[2] = UIColor.Styling.PieChartAnalysis.yellowHappiness
//        self.pieChartView.data?.getDataSetByIndex(3).colors[3] = UIColor.Styling.PieChartAnalysis.greenDisgust
//        self.pieChartView.data?.getDataSetByIndex(4).colors[4] = UIColor.Styling.PieChartAnalysis.blueSadness
//        self.pieChartView.data?.getDataSetByIndex(5).colors[5] = UIColor.Styling.PieChartAnalysis.indigoSurprise
//        self.pieChartView.data?.getDataSetByIndex(6).colors[6] = UIColor.Styling.PieChartAnalysis.violetFear
//        self.pieChartView.data?.getDataSetByIndex(7).colors[7] = UIColor.Styling.PieChartAnalysis.whiteNeutral
        
//        let pieChartColors = pieChartDataSet.dataEntries
//        switch pieChartColors {
//            case "0":
//            
//            case "1":
//            
//            case "2":
//            
//            case "3":
//
//                break
//        }
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
