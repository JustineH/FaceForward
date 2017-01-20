//
//  TabBarViewController.swift
//  FaceForward
//
//  Created by Justine Herman on 1/19/17.
//
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Switch tabs when user leaves app
        NotificationCenter.default.addObserver(self, selector: #selector(returnToCalendarVC), name: NSNotification.Name(rawValue: "userLeftApp"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func returnToCalendarVC() {
        
        if (self.selectedIndex == 1) {
            // Pop to root view controller and switch to first (CalendarVC) tab bar item
            if let currentViewController: UINavigationController = self.viewControllers?[1] as? UINavigationController {
                currentViewController.popToRootViewController(animated: false)
            }
            
            self.selectedIndex = 0
        }
    }
    
}
