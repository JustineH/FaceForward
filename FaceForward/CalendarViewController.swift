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

protocol calendarEventHandlingProtocol : class {
    
    func dateWasClicked(view: JTAppleDayCellView?, cellState: CellState, selectedDate: Date)
}

class CalendarViewController: UIViewController, calendarEventHandlingProtocol {
    
    //MARK: Properties
    
    let currentDate = Date()
    let realmManager = RealmManager()
    
    // DataSource & delegate
    let datasource = DataSource()
    let delegate = Delegate()
    
    // Calendar
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    // Cache the colours so a new colour isn't created every time a cell is displayed
    let notSelectedTextColor = UIColor.darkGray
    let selectedTextColor = UIColor.purple
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        displayPreviousMoods()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    /// Pass the date clicked, goes to DetailedLogVC
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
    
    /// Create calendar
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
    
    /// Display previous mood colours
    func displayPreviousMoods() {
        let realm = try! Realm()
        let resultsData = realm.objects(DataEntry.self)
        delegate.moodData = resultsData
    }
    
    fileprivate func reloadData() {
        calendarView.reloadData()
    }
    
}
