//
//  DetailLogViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import Charts
import RealmSwift

class DetailLogViewController: UIViewController {
    
//MARK: Properties
    @IBOutlet weak var titleDateLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var chartView: LineChartView!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    var passedSurveyDetails: Survey
    
//MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormatDelegate = self
        updateChartWithData()
    }
    
//MARK: Labels
    func updateLabels(){
        titleDateLabel.text = "On \(date) you were..."
        moodLabel.text = passedSurveyDetails.moodInput!
        exerciseLabel.text = passedSurveyDetails.exerciseInput!
        sleepLabel.text = passedSurveyDetails.sleepInput!
        peopleLabel.text = passedSurveyDetails.peopleInput ?? ""
        notesTextView.text = passedSurveyDetails.notesInput ?? ""
    }
    
    
//MARK: Chart
    func updateChartWithData() {
        var emotionEntries: [Survey] = []
        let savedEmotions = getEmotionsFromRealm()
        
        for i in 0..<savedEmotions.count {
            let timeIntervalForDate: TimeInterval = Survey.date.timeIntervalSince1970
            let emotionEntry = LineChartDataEntry(x:Double(i), y:Double(savedEmotions[i].count))
            emotionEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: emotionEntries, label: "emotions")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        let xaxis = chartView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
    }


    func getEmotionsFromRealm() -> Results<Survey>{
        do{
            let realm = try Realm()
            return realm.objects(Survey)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }


}


//MARK: IAxisValueFormatter
extension DetailLogViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm.ss"
        return dateFormatter.string(from: Date(timeIntervalSince1970:value))
    }
}
