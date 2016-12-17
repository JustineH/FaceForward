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
class Emotion: Object {
    dynamic var moodInput = ""
    dynamic var sleepInput = 0.0
    var exerciseInput: Bool?
    dynamic var peopleInput = ""
    dynamic var notesInput = ""
    dynamic var date: Date?
    
    let emotionDictionary = Dictionary<String, Any>() //dictionary of string:anyObjects
    let emotionArray = Array<Any>() //array of anyObjects
    
    override var description: String { return "Emotion{\(moodInput), \(sleepInput), \(exerciseInput), \(peopleInput), \(notesInput), \(date), \(emotionDictionary), \(emotionArray)}"}
}

let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "Emotion"))


// TO CREATE A NEW OBJECT
//let dog = Emotion()
//dog.moodInput =
//    dog.sleepInput =
//    dog.exerciseInput =
//    dog.peopleInput =
//    dog.notesInput =
//    dog.emotionArray =
//    dog.emotionDictionary =


// TO SAVE TO REALM?
//let realm = try! Realm()
//try! realm.write {
//    realm.add(dog)
//}

//TO RETRIEVE FROM REALM?
//let realm = try! Realm()
//let results = realm.objects(dog)
