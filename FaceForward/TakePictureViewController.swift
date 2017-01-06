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
    @IBOutlet weak var confirmPictureLabel: UILabel!
    @IBOutlet weak var noFaceFoundLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePhotoButtonLabel: UIButton!
    @IBOutlet weak var retakePhotoButtonLabel: UIButton!
    @IBOutlet weak var nextButtonLabel: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
//    var percentages = [Double]()
    var mostLikelyMood: String = EmotionName.neutral.rawValue
    var survey: Survey!
    var emotionsDictionaryToSave: Emotion!
    
    // MARK: - Actions -
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextSaveButton(_ sender: Any) {
        
        let newEmotion = emotionsDictionaryToSave
        newEmotion!.largestEmotion = mostLikelyMood

        let realm = try! Realm()
        try! realm.write {
            
            let newEntry = DataEntry()
            newEntry.emotion.append(newEmotion!)
            newEntry.survey.append(survey)
            realm.add(newEntry)
   
        }
        Router(self).showChart(dict: emotionsDictionaryToSave)
    }
    
        
    @IBAction func retakePhotoButton(_ sender: UIButton) {
        self.confirmPictureLabel.isHidden = true
        self.noFaceFoundLabel.isHidden = true
        self.nextButtonLabel.isHidden = true
        self.retakePhotoButtonLabel.isHidden = true
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        self.view.backgroundColor = Styling.Colors.backgroundColor
        imageView.backgroundColor = UIColor.white
        spinner.color = Styling.ActivityIndicatorView.yellowSpinner
        imagePicker.delegate = self
        retakePhotoButtonLabel.isHidden = true
        nextButtonLabel.isHidden = true
        spinner.hidesWhenStopped = true
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        spinner.startAnimating()
        self.imageView.isHidden = false
        takePhotoButtonLabel.isHidden = true
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.spinner.stopAnimating()
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFit

            ServerManager.emotions(from: pickedImage)
            { emotionDictionary in
                if emotionDictionary.count <= 0 {
                    self.noFaceFoundLabel.isHidden = false
                    self.confirmPictureLabel.isHidden = true
                }else{
//                for (name, value) in emotionDictionary {
//                    let percent: Int = Int(round(value * 100))
//                    self.faceResults.text! += "\(name): \(percent)%\n"
////                    self.percentages.append(value)
//                }
                    self.emotionsDictionaryToSave = self.makeItems(dictionary: emotionDictionary)
                    self.mostLikelyMood = self.keyMaxValue(dict: emotionDictionary)!
                    self.confirmPictureLabel.isHidden = false
                    self.nextButtonLabel.isHidden = false
                }
                self.retakePhotoButtonLabel.isHidden = false
            }
        }
            dismiss(animated: true, completion: nil)
    }
    
    func makeItems(dictionary: [String:Double]) -> Emotion? {
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
    
    func keyMaxValue(dict: [String: Double]) -> String? {
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
