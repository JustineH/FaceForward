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
        
        // So we can switch tabs when the user leaves the app
        NotificationCenter.default.addObserver(self, selector: #selector(returnToCalendarVC), name: NSNotification.Name(rawValue: "userLeftApp"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func returnToCalendarVC() {
        
        if (self.selectedIndex == 1) {
            // pop to root view controller
            if let currentViewController: UINavigationController = self.viewControllers?[1] as? UINavigationController {
                currentViewController.popToRootViewController(animated: false)
            }
            
            self.selectedIndex = 0
        }
    }
    
}
