//
//  CalendarViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    //MARK: Properties
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
    @IBOutlet weak var chartView: LineChartView!
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    // We cache our colors because we do not want to be creating
    // a new color every time a cell is displayed. We do not want a laggy
    // scrolling calendar.
    let notSelectedTextColor = UIColor.black
    let selectedTextColor = UIColor.purple
    
    let formatter = DateFormatter()
    let currentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.registerCellViewXib(file: "CalendarCell") // Registering your cell is manditory
        calendarView.registerHeaderView(xibFileNames: ["MonthHeaderView"])
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        calendarView.scrollEnabled = true
        calendarView.scrollingMode = .stopAtEachCalendarFrameWidth
        calendarView.scrollToDate(currentDate)
//        displayPreviousMoods()
        
        axisFormatDelegate = self
        updateChartWithData()
        chartView.noDataText = "No data :("
        
    }
    
    //MARK: Mood Display
//    func displayPreviousMoods() {
//    let realmObjects = []
//        
//        for 0..<realmObjects.count {
//            setBackgroundColor(object: )
//        }
//    }
    
//    func setBackgroundColor(object: ) {
//        guard let myCustomCell = view as? CellView  else {
//            return
//        }
//        let mood = object.mood
//        switch mood {
//        case "angry":
//            myCustomCell.moodColor.backgroundColor = UIColor.red
//        case "joy":
//            myCustomCell.moodColor.backgroundColor = UIColor.yellow
//        case "sorrow":
//            myCustomCell.moodColor.backgroundColor = UIColor.cyan
//        case "surprise":
//            myCustomCell.moodColor.backgroundColor = UIColor.green
//        default:
//            break
//        }
//        myCustomCell.moodColor.isHidden = false
//    }
    
//    func refreshOverallMood(cell: CellState) {
//      for realmObject in realmObjects{
//          if cell.date == realmObject.date{
//            //reassign all the labels
//            overallFace.image = image
//            happyPercent.text =
//            surprisedPercent.text =
//            sadPercent.text =
//            angryPercent.text =
//          }
//      }
    
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            let detailVC:DetailLogViewController = segue.destination as! DetailLogViewController
//        }
//    }
    
    
    //MARK: Chart (move later)
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


