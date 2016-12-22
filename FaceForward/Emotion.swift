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
    var largestEmotion: EmotionName.RawValue!
    var anger = 0.0
    var contempt = 0.0
    var disgust = 0.0
    var fear = 0.0
    var happiness = 0.0
    var neutral = 0.0
    var sadness = 0.0
    var surprise = 0.0

}




