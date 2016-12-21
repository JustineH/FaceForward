//
//  Delegate.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-20.
//
//

import UIKit
import JTAppleCalendar

class Delegate: NSObject, JTAppleCalendarViewDelegate {
    //MARK: Properties
    // We cache our colors because we do not want to be creating
    // a new color every time a cell is displayed.
    let notSelectedTextColor = UIColor.black
    let selectedTextColor = UIColor.purple

    
    //MARK: All the Cells in a Month
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
    
    
    //MARK: Cell Selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = selectedTextColor
            //            refreshOverallMood(cell: cellState)
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = notSelectedTextColor
            } else {
                myCustomCell.dayLabel.textColor = notSelectedTextColor
            }
            
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    
    //MARK: Month Header
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        return CGSize(width: 200, height: 50)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
        let headerCell = (header as? MonthHeaderView)
        let calendar = Calendar.current
        let month = formatMonth(month: calendar.component(.month, from: range.start))
        let year = calendar.component(.year, from: range.start)
        headerCell?.monthLabel.text = "\(month) \(year)"
        
    }
    
    func formatMonth(month: Int) -> String{
        switch month {
        case 1:
            return "January"
        case 2:
            return "Febuary"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
            
        default:
            break
        }
        return ""
    }
    
}
