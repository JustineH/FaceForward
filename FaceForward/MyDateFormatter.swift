//
//  MyDateFormatter.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-23.
//
//

import UIKit

///Format Date
class MyDateFormatter: NSObject {
    
    var calendar = Calendar(identifier: .gregorian)
    
    func configureDate(date: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.timeStyle = .short
        formatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"

        let dateComponents = formatter.string(from: date)
        return "\(dateComponents)"
        
//        let dateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)

//        let month = formatMonth(month: dateComponents.month!)
//        return "\(month) \(dateComponents.day!), \(dateComponents.year!) at \(dateComponents.hour!):\(dateComponents.minute!)"
        
    }

    /// Convert month number to text
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
