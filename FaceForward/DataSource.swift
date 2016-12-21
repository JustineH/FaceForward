//
//  DataSource.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-20.
//
//

import UIKit
import JTAppleCalendar

class DataSource: NSObject, JTAppleCalendarViewDataSource {
    
    //MARK: Properties
    let formatter = DateFormatter()

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
    
    
}
