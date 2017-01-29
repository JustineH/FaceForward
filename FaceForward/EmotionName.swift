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
    
    case happiness = "Happiness"
    case neutral = "Neutral"
    case surprise = "Surprise"
    case sadness = "Sadness"
    case fear = "Fear"
    case anger = "Anger"
    case contempt = "Contempt"
    case disgust = "Disgust"
    
    static func allNamesInOrder() -> [String] {
        return [ EmotionName.happiness.rawValue, EmotionName.neutral.rawValue, EmotionName.surprise.rawValue, EmotionName.sadness.rawValue, EmotionName.fear.rawValue, EmotionName.anger.rawValue, EmotionName.contempt.rawValue, EmotionName.disgust.rawValue]
    }
}

