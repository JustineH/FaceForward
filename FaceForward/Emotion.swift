//
//  Emotion.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-16.
//
//

import UIKit
import RealmSwift

class Emotion: Object {
    
    dynamic var largestEmotion = ""
    dynamic var anger : Double = 0.0
    dynamic var contempt : Double  = 0.0
    dynamic var disgust : Double = 0.0
    dynamic var fear : Double = 0.0
    dynamic var happiness : Double = 0.0
    dynamic var neutral : Double = 0.0
    dynamic var sadness : Double = 0.0
    dynamic var surprise : Double = 0.0

}




