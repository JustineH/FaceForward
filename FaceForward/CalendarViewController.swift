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

protocol calendarEventHandlingProtocol : class{
    func dateWasClicked(view: JTAppleDayCellView?, cellState: CellState, selectedDate: Date)
}
class CalendarViewController: UIViewController, calendarEventHandlingProtocol {
    
    //MARK: Properties
    let currentDate = Date()
    let realmManager = RealmManager()
    
    //dataSource & delegate
    let datasource = DataSource()
    let delegate = Delegate()
    
    //calendar
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    // We cache our colors because we do not want to be creating
    // a new color every time a cell is displayed.
    let notSelectedTextColor = UIColor.black
    let selectedTextColor = UIColor.purple
    
//    //chart
//    @IBOutlet weak var chartView: ScatterChartView!
//    weak var axisFormatDelegate: IAxisValueFormatter?
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        displayPreviousMoods()
//        createChart()
    }
    
    func dateWasClicked(view: JTAppleDayCellView?, cellState: CellState, selectedDate: Date) {
        guard let myCustomCell = view as? CellView  else {
            print("Error with cell selection")
            return
        }
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = selectedTextColor
            Router(self).showDetail(date: selectedDate)
        } else {
            myCustomCell.dayLabel.textColor = notSelectedTextColor
        }
    }
    
    func configureView() {
        
        calendarView.registerCellViewXib(file: "CalendarCell")
        calendarView.registerHeaderView(xibFileNames: ["MonthHeaderView"])
        delegate.delegate = self
        calendarView.delegate = delegate
        calendarView.dataSource = datasource
        
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        calendarView.scrollingMode = .stopAtEachCalendarFrameWidth
        calendarView.scrollToDate(currentDate)
    }
    
    //MARK: Moods Display
    func displayPreviousMoods() {
        let realm = try! Realm()
        let resultsData = realm.objects(DataEntry.self)
        delegate.moodData = resultsData
    }
    
    
//    //MARK: Chart (move later)
//    func createChart() {
//        axisFormatDelegate = self
//        chartView.noDataText = "No data :("
//        chartView.chartDescription?.text = "for the month"
//        
//        chartView.rightAxis.drawLabelsEnabled = false
//        chartView.leftAxis.gridLineWidth = 0
//        chartView.rightAxis.gridLineWidth = 0
//        chartView.xAxis.gridLineWidth = 0
//        
//        if realmManager.getSavedEntriesFromDatabase()?.count != 0 {
//            updateChart()
//        } else {
//            
//        }
//        
//    }
//
//    func updateChart() {
//        var dataEntries: [ChartDataEntry] = []
//        guard let savedEntries = realmManager.getSavedEntriesFromDatabase() else {
//            return
//        }
//        
//        for i in 0..<savedEntries.count {
//            let date = getDate(savedDate: savedEntries[i].date)
//            let mood = savedEntries[i].survey[0].moodInput
//            if let moodValue = mood {
//                var plotY = 0.0
//                switch moodValue {
//                case "great":
//                    plotY = 0
//                case "good":
//                    plotY = 1
//                case "average":
//                    plotY = 2
//                case "bad":
//                    plotY = 3
//                case "veryBad":
//                    plotY = 4
//                default:
//                    break
//                }
//                let dataEntry = ChartDataEntry(x: Double(Int(date)), y: Double(plotY))
//                dataEntries.append(dataEntry)
//            }
//        }
//        
//        let chartDataSet = ScatterChartDataSet(values: dataEntries, label: "Mood")
//        chartDataSet.setScatterShape(ScatterChartDataSet.Shape.circle)
//        let chartData = ScatterChartData(dataSet: chartDataSet)
//        chartView.data = chartData
//        
//        let xaxis = chartView.xAxis
//        xaxis.valueFormatter = axisFormatDelegate
//    }

//    func getDate(savedDate: Date) -> (Int){
//        let date = savedDate
//        let calendar = Calendar.current
//        let components = calendar.component(.day, from: date)
//        return components
//    }
    
}


//    //MARK: IAxisValueFormatter
//extension CalendarViewController: IAxisValueFormatter {
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        //        let dateFormatter = DateFormatter()
//        //        dateFormatter.dateFormat = "MM dd"
//        return "\(Int(value))"
//    }
//}




