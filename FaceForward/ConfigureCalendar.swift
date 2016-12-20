//
//  ConfigureCalendar.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-16.
//
//

import UIKit
import JTAppleCalendar

extension CalendarViewController {
    
    
    //MARK: Configure Calendar
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "MM dd yyyy"
        
        let startDate = formatter.date(from: "12 09 1900")!
        let endDate = formatter.date(from: "12 09 2100")!
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .off,
            firstDayOfWeek: .sunday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        
        let myCustomCell = cell as! CellView
        myCustomCell.dayLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.isHidden = false
        } else {
            myCustomCell.isHidden = true
        }
        
        handleCellSelection(view: cell, cellState: cellState)
    }
    
       
}
