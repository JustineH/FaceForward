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


let microsoftUrl = "https://api.projectoxford.ai/emotion/v1.0/recognize"
let microsoftKey = FFConstants.microsoftKey

class ServerManager: NSObject {
    
    
    class func emotions(from image: UIImage, completion:@escaping ([String:Double])->()) {
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
//                    print("Validation successful.")
                    let json = JSON(response.result.value!)
                    var result = [String:Double]()
                    if let dictionary = json[0]["scores"].dictionary {
                        for (name, value) in dictionary {
                            result[name] = value.double
                        }
                        
           
                    }
                    completion(result)
                
                case .failure(let error):
                    print(error)
            }
            
        }
    }

}
