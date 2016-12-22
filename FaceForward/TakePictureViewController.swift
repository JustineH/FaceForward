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

class TakePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    // MARK: - Properties -
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var faceResults: UITextView!
    @IBOutlet weak var takePhotoButtonLabel: UIButton!
    @IBOutlet weak var retakePhotoButtonLabel: UIButton!
    @IBOutlet weak var nextButtonLabel: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Actions -
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func retakePhotoButton(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextSaveButton(_ sender: UIButton) {
//        let realm = try! Realm()
//        
//        try! realm.write {
//            realm.add(self)
//        }
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
        self.faceResults.backgroundColor = Styling.Colors.backgroundColor
        self.faceResults.textColor = Styling.Colors.fontBody
        spinner.color = Styling.ActivityIndicatorView.yellowSpinner
        imagePicker.delegate = self
        faceResults.isHidden = true
        retakePhotoButtonLabel.isHidden = true
        nextButtonLabel.isHidden = true
        spinner.hidesWhenStopped = true
        
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        spinner.startAnimating()
        self.imageView.isHidden = false
        takePhotoButtonLabel.isHidden = true
        self.faceResults.isHidden = false
        self.faceResults.text = ""
        
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.spinner.stopAnimating()
            retakePhotoButtonLabel.isHidden = false
            nextButtonLabel.isHidden = false
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFit

            ServerManager.emotions(from: pickedImage)
            { emotionDictionary in
                for (name, value) in emotionDictionary {
                    let percent: Int = Int(round(value * 100))
                    self.faceResults.text! += "\(name): \(percent)%\n"
                }
            }
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


