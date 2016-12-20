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
    var moodInput: Mood!
    var sleepInput: Sleep!
    var exerciseInput: Bool!
    var peopleInput: String?
}
