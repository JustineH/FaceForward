//
//  Styling.swift
//  FaceForward
//
//  Created by Justine Herman on 12/15/16.
//
//

import UIKit

struct Styling {
    
    struct Colors {
        
        static var backgroundColor = UIColor.white
        static var buttons = UIColor(red:(145.0/255), green:(45.0/255), blue:(165.0/255), alpha: 1)
        static var buttonBorderColor = UIColor(red:(145.0/255), green:(45.0/255), blue:(165.0/255), alpha: 1)
        static var buttonTextColor = UIColor.white
        static var fontBody = UIColor(red: 46.0/255.0, green: 48.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        static var textFieldColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        static var calendarMonthColor = UIColor(red:(122.0/255), green:(205.0/255), blue:(169.0/255), alpha: 1)
        
        static var brightPinkColor = UIColor(red:(244.0/255), green:(17.0/255), blue:(92.0/255), alpha: 1)
        static var yellowColor = UIColor(red:(255.0/255), green:(173.0/255), blue:(64.0/255), alpha: 1)
        static var redColor = UIColor(red:(194.0/255), green:(0.0/255), blue:(62.0/255), alpha: 1)
        static var darkBlueColor = UIColor(red:(66.0/255), green:(0.0/255), blue:(109.0/255), alpha: 1)
        static var darkPurpleColor = UIColor(red:(88.0/255), green:(7.0/255), blue:(169.0/255), alpha: 1)
        static var orangeColor = UIColor(red:(254.0/255), green:(110.0/255), blue:(75.0/255), alpha: 1)
        static var purpleColor = UIColor(red: 141.0/255.0, green: 0.0/255.0, blue: 129.0/255.0, alpha: 1.0)
        static var pinkColor = UIColor(red:(250.0/255), green:(81.0/255), blue:(152.0/255), alpha: 1)
        
    }
    
    static func styleButton(button: UIButton) {
        
        button.backgroundColor = self.Colors.buttons
        button.tintColor = self.Colors.buttonTextColor
        button.layer.borderColor = self.Colors.buttonBorderColor.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 5.0
        
    }

    static func styleShuffleButton(button: UIButton) {
        
        button.backgroundColor = self.Colors.purpleColor
        button.tintColor = self.Colors.buttonTextColor
        button.layer.cornerRadius = 5.0
    }

    struct ActivityIndicatorView {
        
        static var purpleSpinner = UIColor(red: 157.0/255.0, green: 166.0/255.0, blue: 214.0/255.0, alpha: 1.0)
    }
    
}
