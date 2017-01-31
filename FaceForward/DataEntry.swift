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
    let emotion = List<Emotion>()
    let survey = List<Survey>()
    
    convenience init(emotion: Emotion, survey: Survey){
        
        self.init()
        self.date = Date()
       
    }
    
}
