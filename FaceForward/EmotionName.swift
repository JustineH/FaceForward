//
//  EmotionName.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-19.
//
//

import Foundation
import UIKit

enum EmotionName: String {
    case anger = "anger"
    case contempt = "contempt"
    case disgust = "disgust"
    case fear = "fear"
    case happiness = "happiness"
    case neutral = "neutral"
    case sadness = "sadness"
    case surprise = "surprise"

    func setCalendarCellColor() -> UIColor {
        switch self {
        case .anger:
            return UIColor.red
        case .contempt:
            return UIColor.yellow
        case .disgust:
            return UIColor.cyan
        case .fear:
            return UIColor.green
        case .happiness:
            return UIColor.cyan
        case .neutral:
            return UIColor.purple
        case .sadness:
            return UIColor.black
        case .surprise:
            return UIColor.brown
        }
    }
}

