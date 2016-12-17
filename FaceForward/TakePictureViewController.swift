//
//  TakePictureViewController.swift
//  FaceForward
//
//  Created by Justine Herman on 12/17/16.
//
//

import UIKit
import SwiftyJSON

class TakePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    let session = URLSession.shared
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var faceResults: UITextView!
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        faceResults.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TakePictureViewController {
    
    func analyzeResults(_ dataToParse: Data) {
        
        DispatchQueue.main.async(execute: {
            
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            self.imageView.isHidden = false
            self.faceResults.isHidden = false
            self.faceResults.text = ""
            
            if (errorObj.dictionaryValue != [:]) {
                self.faceResults.text = "Error code \(errorObj["code"]): \(errorObj["message"])"
            } else {
                print(json)
                let responses: JSON = json["responses"][0]
     
                let faceAnnotations: JSON = responses["faceAnnotations"]
                if faceAnnotations != JSON.null {
                    let emotions: Array<String> = ["joy", "sorrow", "surprise", "anger"]
                    
                    let numPeopleDetected:Int = faceAnnotations.count
                    
                    self.faceResults.text = "Number of people detected: \(numPeopleDetected)\n\nEmotions detected:\n"
                    
                    var emotionLikelihoods: [String: Double] = ["VERY_LIKELY": 0.9, "LIKELY": 0.75, "POSSIBLE": 0.5, "UNLIKELY": 0.25, "VERY_UNLIKELY": 0.0]
                    
                    for index in 0..<numPeopleDetected {
                        let personData:JSON = faceAnnotations[index]
                        
                        for emotion in emotions {
                            for (key, value) in emotionLikelihoods {
                                let likelihoodNum = value
                                let numFormatter = NumberFormatter()
                                numformatter.numberStyle = .percent
                                self.faceResults.text! += "\(emotions): \(percent)%\n)"

                            }
                            let result:String = personData[emotion].stringValue
                                                        emotionLikelihoods
                            
                        }
//                        else {
//                            self.faceResults.text = "No faces found."
//                        }
                        
                        
                    }
                    
                }
            }
            
        }
            
    )};
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imageView.contentMode = .scaleAspectFit
        imageView.image = pickedImage
        spinner.startAnimating()
        //            faceResults.isHidden = true
        
        let binaryImageData = base64EncodeImage(pickedImage)
        createRequest(with: binaryImageData)
    }
    
    dismiss(animated: true, completion: nil)
}

func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
}

func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
    UIGraphicsBeginImageContext(imageSize)
    image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    let resizedImage = UIImagePNGRepresentation(newImage!)
    UIGraphicsEndImageContext()
    return resizedImage!
}


fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


