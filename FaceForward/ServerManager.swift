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
fileprivate let fourMB = 4000000

class ServerManager: NSObject {
    
    class func emotions(from image: UIImage, completion:@escaping ([String:Double])->()) {

        let data = imageData(image, belowSize: fourMB)
        let headers = [
            "Ocp-Apim-Subscription-Key": microsoftKey,
            "Content-Type": "application/octet-stream"
        ]
        Alamofire.upload(data, to: microsoftUrl, headers: headers)
        .responseJSON
        {response in
            switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    
                    if let error = json["error"].dictionary {
                        // Gets called when an image is too big, too small or for other reasons
                        let errorMessage = error["message"]?.string
                        print("error \(errorMessage)")
                    }
                    
                    var result = [String:Double]()
                    if let dictionary = json[0]["scores"].dictionary {
                        for (name, value) in dictionary {
                            result[name] = value.double
                        }
                    }
                    
                    completion(result)
                
                case .failure(let error):
                    print(error)
                    completion(["\(error.localizedDescription)":0])
            }
        }
    }
    
    /**
     Create data from a UIImage
     
     - parameter image: The image to create the data from
     - parameter size: The size, in bytes, that the data has to be below
     - returns: data
     
    */
    private class func imageData(_ image: UIImage, belowSize limit: Int) -> Data {
        
        var quality:CGFloat = 1.0
        
        var imageData = UIImageJPEGRepresentation(image, quality)!
       
        while (imageData.count > limit) {
            quality -= 0.1
            imageData = UIImageJPEGRepresentation(image, quality)!
        }
        
        return imageData
    }

}
