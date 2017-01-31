//
//  Mood.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-19.
//
//

import Foundation

enum Mood: String {

        case veryBad = "Very bad"
        case bad = "Bad"
        case average = "Average"
        case good = "Good"
        case great = "Great"
    
        func toValue() -> Int{
            switch self{
            case.veryBad:
                return 0
            case.bad:
                return 1
            case.average:
                return 2
            case.good:
                return 3
            case.great:
                return 4
            }
        }
    
}
