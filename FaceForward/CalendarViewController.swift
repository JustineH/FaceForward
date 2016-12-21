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
        let savedEntries = getSavedEntriesFromDatabase()
        for i in 0..<savedEntries.count {
            setBackgroundColor(mood: savedEntries[i].emotion.longestEmotion)
        }
    }
    
    func setBackgroundColor(mood: EmotionName) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        let color = EmotionName.setCalendarCellColor(mood)
        myCustomCell.moodColor.backgroundColor = color()
        myCustomCell.moodColor.isHidden = false
    }
    
    func refreshOverallMood(cell: CellState) {
        let savedEntries = getSavedEntriesFromDatabase()
        var dictionary: [EmotionName:Double] = [:]
        for savedEntry in savedEntries {
            if savedEntry.date == cell.date {
                dictionary = savedEntry.emotion.emotions
            }
        }
        happyPercent.text = "\(dictionary[EmotionName.happiness])"
        
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
        
        for i in (savedEntries.count - 31)..<savedEntries.count {
            let date = getDate(savedDate: savedEntries[i].date)
            let moodValue = savedEntries[i].survey.moodInput.toValue()
            let dataEntry = ChartDataEntry(x: Double(Int(date)), y: Double(moodValue))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = ScatterChartDataSet(values: dataEntries, label: "emotions")
        let chartData = ScatterChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        let xaxis = chartView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
    }

    func getDate(savedDate: Date) -> (Int){
        let date = savedDate
        let calendar = Calendar.current
        let components = calendar.component(.day, from: date)
        return components
    }

    func getSavedEntriesFromDatabase() -> Results<DataEntry>{
        do {
            let realm = try Realm()
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
        return "\(value)"
    }
}
    


