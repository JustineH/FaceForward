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
    @IBOutlet weak var timeOutLabel: UILabel!
    @IBOutlet weak var retakePhotoButtonLabel: UIButton!
    @IBOutlet weak var nextButtonLabel: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var spinnerBackground: UIView!
    @IBOutlet weak var cameraImage: UIImageView!
    
//    var percentages = [Double]()
    var mostLikelyMood: String = EmotionName.neutral.rawValue
    var survey: Survey!
    var emotionsDictionaryToSave: Emotion!
    
    // MARK: - Actions -
    
    /// Brings up camera to take a photo
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    /// Creates a entry in realm and goes to the chartVC
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
        self.nextButtonLabel.isHidden = true
        Router(self).showChart(dict: emotionsDictionaryToSave)
    }
    
    /// Brings up camera to retake the photo and hides all the labels until photo is loaded
    @IBAction func retakePhotoButton(_ sender: UIButton) {
        self.confirmPictureLabel.isHidden = true
        self.noFaceFoundLabel.isHidden = true
        self.nextButtonLabel.isHidden = true
        self.timeOutLabel.isHidden = true
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - View -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func setup() {
        self.view.backgroundColor = Styling.Colors.backgroundColor
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        
        spinner.color = Styling.ActivityIndicatorView.purpleSpinner
        spinner.hidesWhenStopped = true
        
        imagePicker.delegate = self
        
        confirmPictureLabel.textColor = Styling.Colors.fontBody
        noFaceFoundLabel.textColor = Styling.Colors.fontBody
        timeOutLabel.textColor = Styling.Colors.fontBody
        
        Styling.styleButton(button: nextButtonLabel)
        Styling.styleButton(button: retakePhotoButtonLabel)

    }

    //MARK: - Take the Picture -
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        spinner.startAnimating()
        imageView.isHidden = false
        spinner.isHidden = false
        spinnerBackground.isHidden = false
        takePhotoButtonLabel.isHidden = true
        cameraImage.isHidden = true
    
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFit

            ServerManager.emotions(from: pickedImage)
            { emotionDictionary in
                self.spinner.stopAnimating()
                self.spinnerBackground.isHidden = true
                
                if emotionDictionary.count == 1 {
                    self.timeOutLabel.isHidden = false
                }
                else if emotionDictionary.count <= 0 {
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

    /// Makes a new Emotion for a Realm entry, not saved yet
    func makeItems(dictionary: [String:Double]) -> Emotion? {
        let new = Emotion()
        new.anger = dictionary["anger"] ?? 0
        new.contempt = dictionary["contempt"] ?? 0
        new.disgust = dictionary["disgust"] ?? 0
        new.fear = dictionary["fear"] ?? 0
        new.happiness = dictionary["happiness"] ?? 0
        new.neutral = dictionary["neutral"] ?? 0
        new.sadness = dictionary["sadness"] ?? 0
        new.surprise = dictionary["surprise"] ?? 0
        
        return new
    }
    
    /// Finds the largest emotion
    func keyMaxValue(dict: [String: Double]) -> String? {
        for (key, value) in dict {
            if value == dict.values.max() {
                return key
            }
        }
        return nil
    }
    
    /// Dismiss the camera
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    /// Resizes the image if it's too big?? 
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImageJPEGRepresentation(newImage!, 0.75)
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

