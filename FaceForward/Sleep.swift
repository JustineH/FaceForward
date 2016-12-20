//
//  Sleep.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-19.
//
//

import Foundation

struct Sleep{
    enum SleepInput {
        case great
        case well
        case average
        case poorly
        case veryPoorly
        
        func toString() -> String{
            switch self{
            case.great:
                return "great"
            case.well:
                return "well"
            case.average:
                return "average"
            case.poorly:
                return "poorly"
            case.veryPoorly:
                return "very poorly"
            }
        }
    }
    let sleep: SleepInput
}
