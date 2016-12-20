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
    // We cache our colors because we do not want to be creating
    // a new color every time a cell is displayed.
    let notSelectedTextColor = UIColor.black
    let selectedTextColor = UIColor.purple
    
    let formatter = DateFormatter()
    let currentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = true
        
        configureView()
//        displayPreviousMoods()
   
    }
    
    func configureView() {
        
        calendarView.registerCellViewXib(file: "CalendarCell")
        calendarView.registerHeaderView(xibFileNames: ["MonthHeaderView"])
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        axisFormatDelegate = self
        chartView.noDataText = "No data :("
        
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        calendarView.scrollEnabled = true
        calendarView.scrollingMode = .stopAtEachCalendarFrameWidth
        calendarView.scrollToDate(currentDate)
        
        mainScrollView.contentSize = CGSize(width: view.bounds.size.width, height: 1000)
        
    }
    
//    func refreshOverallMood(cell: CellState) {
//      for i in savedEntries{
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
    


