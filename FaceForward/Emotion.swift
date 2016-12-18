//
//  Emotion.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-16.
//
//

import UIKit
import RealmSwift

// create a list of stuff after the photo view controller and init this object
class Survey: Object {
    dynamic var moodInput = ""
    dynamic var sleepInput = 0.0
    var exerciseInput: Bool?
    dynamic var peopleInput = ""
    dynamic var notesInput = ""
    dynamic var date: Date?
    
    let emotionDictionary = Dictionary<String, Any>() //dictionary of string:anyObjects
    
    override var description: String { return "Emotion{\(moodInput), \(sleepInput), \(exerciseInput), \(peopleInput), \(notesInput), \(date), \(emotionDictionary)}"}
}

let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "Emotion"))

class Emotion: Object {
    dynamic var joyName = ""
    let emotionAmounts = List<EmotionAmount>()
    dynamic var date: Date?
}

class EmotionAmount: Object {
    dynamic var eAmount = 0.0
    
}

