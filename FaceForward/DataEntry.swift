//
//  DataEntry.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-19.
//
//

import UIKit
import RealmSwift

class DataEntry: Object {
    dynamic var date = Date()
    dynamic var emotion: Emotion?
    dynamic var survey: Survey?
}
