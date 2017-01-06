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
    @IBOutlet weak var facialEmotionResults: UITextView!
    
    dynamic var emotionsToPassToPieChart = [String:Double]()
    dynamic var emotionsArray = [String]()
    var dict = Emotion()
    
    
    @IBAction func nextToSuggestionsButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Assessment Results"
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
        
        let emotionsPercentage = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        setChart(dataPoints: emotionsArray, values: emotionsPercentage)
        updateChartData()
        showResults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        let legend = pieChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .left
        legend.drawInside = false
        legend.orientation = .horizontal
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = false
        pieChartView.legend.enabled = true
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.rotationEnabled = true
        pieChartView.highlightPerTapEnabled = false
        pieChartView.animate(xAxisDuration: 2.0)
        pieChartView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
    }
        
    func updateChartData() {
        
        var colors: [UIColor] = []
       // var valueColors = [UIColor]()
       
        var dataEntries: [PieChartDataEntry] = []
        
        
        for emotion in emotionsToPassToPieChart.keys {
            
            let dataEntry = PieChartDataEntry(value: emotionsToPassToPieChart[emotion]!, label: emotion)
            let orangeColor = UIColor(red:(241.0/255), green:(143.0/255), blue:(1.0/255), alpha: 1)
            let yellowColor = UIColor(red:(255.0/255), green:(186.0/255), blue:(2.0/255), alpha: 1)
            let blueColor = UIColor(red:(10.0/255), green:(66.0/255), blue:(161.0/255), alpha: 1)
            let greenColor = UIColor(red:(32.0/255), green:(252.0/255), blue:(143.0/255), alpha: 1)
            let pinkColor = UIColor(red:(250.0/255), green:(8.0/255), blue:(120.0/255), alpha: 1)
            let purpleColor = UIColor(red: 68.0/255.0, green: 3.0/255.0, blue: 129.0/255.0, alpha: 1.0)
            let indigoColor = UIColor(red:(53.0/255), green:(15.0/255), blue:(102.0/255), alpha: 1)
            let neutralColor = UIColor(red:(232.0/255), green:(72.0/255), blue:(85.0/255), alpha: 1)

            colors.append(orangeColor)
            colors.append(yellowColor)
            colors.append(blueColor)
            colors.append(greenColor)
            colors.append(pinkColor)
            colors.append(purpleColor)
            colors.append(indigoColor)
            colors.append(neutralColor)
            
          //  valueColors.append(UIColor.clear)
            dataEntries.append(dataEntry)
        }
        
//        let pFormatter: NumberFormatter = NumberFormatter()
//        pFormatter.numberStyle = NumberFormatter.Style.percent
//        pFormatter.maximumFractionDigits = 1
//        pFormatter.multiplier! = 100.0
//        pFormatter.percentSymbol = " %"
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let data: PieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartDataSet.drawValuesEnabled = false
//        pieChartDataSet.yValuePosition = .outsideSlice
//        pieChartDataSet.valueColors = valueColors
//        pieChartDataSet.valueLinePart1Length = 0.5
//        pieChartDataSet.valueLinePart2Length = 0.4
//        pieChartDataSet.valueLineVariableLength = true
//        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        pieChartView.data = data
 
        pieChartDataSet.colors = colors
        
    }
    
    func showResults() {

        for (name, value) in emotionsToPassToPieChart {
            let percent: Int = Int(round(value * 100))
            self.facialEmotionResults.text! += "\(name): \(percent)%\n"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
