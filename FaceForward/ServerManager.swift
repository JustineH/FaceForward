//
//  ServerManager.swift
//  FaceForward
//
//  Created by Justine Herman on 12/19/16.
//
//

import Foundation
import SwiftyJSON
import Alamofire


// call from Model file
enum EmotionName: String {
    case sadness = "sadness"
    case anger = "anger"
    case happiness = "happiness"
    case fear = "fear"
    case neutral = "neutral"
    case contempt = "contempt"
    case disgust = "disgust"
    case surprise = "surprise"
}

let microsoftUrl = "https://api.projectoxford.ai/emotion/v1.0/recognize"
let microsoftKey = FFConstants.microsoftKey

class ServerManager: NSObject {
    
    
    class func emotions(from image: UIImage, completion:@escaping ([EmotionName:Double])->()) {
        let imageData = UIImagePNGRepresentation(image)!
        let headers = [
            "Ocp-Apim-Subscription-Key": microsoftKey,
            "Content-Type": "application/octet-stream"
        ]
        Alamofire.upload(imageData, to: microsoftUrl, headers: headers)
        .responseJSON
        {response in
            switch response.result {
                case .success:
                    print("Validation successful.")
                    let json = JSON(response.result.value!)
                    var result = [EmotionName:Double]()
                    for (name, value) in json[0]["scores"].dictionary! {
                        result[EmotionName(rawValue: name)!] = value.double
                    }
                        completion(result)
                case .failure(let error):
                    print(error)
            }
            
        }
    }


}
