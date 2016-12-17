//
//  NetworkViewController.swift
//  FaceForward
//
//  Created by Justine Herman on 12/17/16.
//
//

import UIKit
import Foundation
import SwiftyJSON

internal class NetworkViewController: UIViewController {
    
    fileprivate static let apiVersion = "v1"
    fileprivate static let baseURL = "https://vision.googleapis.com/" + NetworkViewController.apiVersion + "/images:annotate"
    fileprivate var apiKey: String?
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    fileprivate func buildQueryURL() -> URL? {
        if var components = URLComponents(string: NetworkViewController.baseURL) {
            components.queryItems = [URLQueryItem(name: "key", value: self.apiKey)]
            return components.url
        }
        return nil
    }
    
    fileprivate func requestHeaders() -> [String: String] {
        return ["Content-Type": "application/json"];
    }
}
    
extension NetworkViewController {
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)
        
        if (imagedata?.count > 4194304) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }
        
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func createRequest(with imageBase64: String) {
        
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": imageBase64
                ],
                "features": [
                    [
                        "type": "FACE_DETECTION",
                        "maxResults": 1
                    ]
                ]
            ]
        ]
        let jsonObject = JSON(jsonDictionary: jsonRequest)
        
        guard let data = try? jsonObject.rawData() else {
            return
        }
        
        request.httpBody = data
        
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }
    
    func runRequestOnBackgroundThread(_ request: URLRequest) {
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            self.analyzeResults(data)
        }
        
        task.resume()
    }
}



