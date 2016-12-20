//
//  Mood.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-19.
//
//

import Foundation

struct Mood {
    enum MoodInput {
        case great
        case good
        case average
        case bad
        case veryBad
        
        func toString() -> String{
            switch self{
            case.great:
                return "great"
            case.good:
                return "good"
            case.average:
                return "average"
            case.bad:
                return "bad"
            case.veryBad:
                return "very bad"
            }
        }
    }
    let mood: MoodInput
}
