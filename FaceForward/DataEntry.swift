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
//    dynamic var emotion: Emotion?
//    dynamic var survey: Survey?
    
    let emotion = List<Emotion>()
    let survey = List<Survey>()
    
    convenience init(emotion: Emotion, survey: Survey){
        self.init()
        self.date = Date()
//        self.emotion = emotion
//        self.survey = survey
       
    }
    
}
