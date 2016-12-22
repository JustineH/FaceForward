//
//  TakePictureViewController.swift
//  FaceForward
//
//  Created by Justine Herman on 12/16/16.
//
//

import UIKit
import Foundation
import SwiftyJSON
import RealmSwift


class TakePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    // MARK: - Properties -
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var faceResults: UITextView!
    @IBOutlet weak var nextButton: UIButton!
//   @IBOutlet weak var spinner: UIActivityIndicatorView!
    var percentages = [Double]()
    var mostLikelyMood: String = EmotionName.anger.rawValue
    var survey: Survey!
    var emotionsDictionaryToSave: Emotion!
    
    // MARK: - Actions -
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextSaveButton(_ sender: Any) {
        var newEmotion = Emotion()
        newEmotion = emotionsDictionaryToSave
        newEmotion.largestEmotion = mostLikelyMood
        
        let newEntry = DataEntry()
        newEntry.survey = survey
        newEntry.emotion = newEmotion
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(newEntry)
        }
        
//        Router(self).showChart(dict: emotionsToSave)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        faceResults.isHidden = true
//        spinner.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.imageView.isHidden = false
//            spinner.startAnimating()
//            faceResults.isHidden = true
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
//      self.spinner.stopAnimating()
            self.faceResults.isHidden = false
            self.faceResults.text = ""
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFit

            ServerManager.emotions(from: pickedImage)
            { emotionDictionary in
                for (name, value) in emotionDictionary {
                    let percent: Int = Int(round(value * 100))
                    self.faceResults.text! += "\(name): \(percent)%\n"
                    self.percentages.append(value)
                }
                
                self.emotionsDictionaryToSave = self.makeItems(dictionary: emotionDictionary)
                self.mostLikelyMood = self.keyMinValue(dict: emotionDictionary)!
            }
        }
            dismiss(animated: true, completion: nil)
    }
    
    func makeItems(dictionary: [String:Double]) -> Emotion {
        let new = Emotion()
        new.anger = dictionary["anger"]!
        new.contempt = dictionary["contempt"]!
        new.disgust = dictionary["disgust"]!
        new.fear = dictionary["fear"]!
        new.happiness = dictionary["happiness"]!
        new.neutral = dictionary["neutral"]!
        new.sadness = dictionary["sadness"]!
        new.surprise = dictionary["surprise"]!
        return new
    }
    
    func keyMinValue(dict: [String: Double]) -> String? {
        for (key, value) in dict {
            if value == dict.values.max() {
                return key
            }
        }
        return nil
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

}


//extension TakePictureViewController {
//    func base64EncodeImage(_ image: UIImage) -> String {
//        var imagedata = UIImagePNGRepresentation(image)
//        
//        // Resize the image if it exceeds the 4MB API limit
//        if ((imagedata!.count) > 4096) {
//            let oldSize: CGSize = image.size
//            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
//            imagedata = resizeImage(newSize, image: image)
//        }
//        
//        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
//    }
//
//}
//    




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


