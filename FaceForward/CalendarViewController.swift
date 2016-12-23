//
//  CalendarViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import JTAppleCalendar
import Charts
import RealmSwift

class CalendarViewController: UIViewController {
    
    //MARK: Properties
    let currentDate = Date()
    
    //dataSource & delegate
    let datasource = DataSource()
    let delegate = Delegate()
    
    var test2 : Emotion?
    
    //calendar
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var LogsTableView: UITableView!
    
    //labels
    @IBOutlet weak var overallFace: UIImageView!
    @IBOutlet weak var happyPercent: UILabel!
    @IBOutlet weak var surprisedPercent: UILabel!
    @IBOutlet weak var sadPercent: UILabel!
    @IBOutlet weak var angryPercent: UILabel!
    
    //chart
    @IBOutlet weak var chartView: ScatterChartView!
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    //scroll
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        displayPreviousMoods()
     //   updateChart()
   
    }
    
    func configureView() {
        
        calendarView.registerCellViewXib(file: "CalendarCell")
        calendarView.registerHeaderView(xibFileNames: ["MonthHeaderView"])
        
        calendarView.delegate = delegate
        calendarView.dataSource = datasource
        
        axisFormatDelegate = self
        chartView.noDataText = "No data :("
        
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        calendarView.scrollEnabled = true
        calendarView.scrollingMode = .stopAtEachCalendarFrameWidth
        calendarView.scrollToDate(currentDate)
        
        mainScrollView.contentSize = CGSize(width: view.bounds.size.width, height: 1000)
        
    }
    
    //MARK: Moods Display
    func displayPreviousMoods() {
        let realm = try! Realm()
        let resultsData = realm.objects(DataEntry.self)
        delegate.moodData = resultsData
//        let obj = resultsData.first
//        let emotionWorking = obj?.emotion[0]
    
//        for dataEntry in resultsData {
//            delegate.moodColor = (obj?.emotion[0].largestEmotion)!
//        }
//        print(resultsData)
    }
    
    func refreshOverallMood(cell: CellState) {
        let savedEntries = getSavedEntriesFromDatabase()
        for savedEntry in savedEntries {
            if savedEntry.date == cell.date {

            }
        }
//        happyPercent.text = ""
        
    }
    
    //MARK: Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            let detailVC:DetailLogViewController = segue.destination as! DetailLogViewController
//        }
//    }


    //MARK: Chart (move later)
    func updateChart() {
        var dataEntries: [ChartDataEntry] = []
        let savedEntries = getSavedEntriesFromDatabase()
        
        for i in 0..<savedEntries.count {
            let date = getDate(savedDate: savedEntries[i].date)
            let mood = savedEntries[i].survey[0].moodInput
            if let moodValue = mood {
                var plotY = 0.0
                switch moodValue {
                case "great":
                    plotY = 0
                case "good":
                    plotY = 1
                case "average":
                    plotY = 2
                case "bad":
                    plotY = 3
                case "veryBad":
                    plotY = 4
                default:
                    break
                }
                let dataEntry = ChartDataEntry(x: Double(Int(date)), y: Double(plotY))
                dataEntries.append(dataEntry)
            }
        }
        
        let chartDataSet = ScatterChartDataSet(values: dataEntries, label: "emotions")
        let chartData = ScatterChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        let xaxis = chartView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
        print(dataEntries)
    }

    func getDate(savedDate: Date) -> (Int){
        let date = savedDate
        let calendar = Calendar.current
        let components = calendar.component(.day, from: date)
        return components
    }

    func getSavedEntriesFromDatabase() -> Results<DataEntry>{
        
        do {
            let realm = try! Realm()
            return realm.objects(DataEntry.self)
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}


    //MARK: IAxisValueFormatter
extension CalendarViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "MM dd"
        return "\(Int(value))"
    }
}
    


