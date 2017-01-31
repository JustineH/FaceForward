//
//  Survey.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-19.
//
//

import UIKit
import RealmSwift

class Survey: Object {
    
    dynamic var moodInput: Mood.RawValue!
    dynamic var sleepInput: Sleep.RawValue!
    dynamic var exerciseInput = false
    dynamic var peopleInput: String?
    
}
