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
    var longestEmotion: EmotionName!
    var emotions: [EmotionName:Double] = [:]

}



