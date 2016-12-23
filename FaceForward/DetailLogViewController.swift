//
//  DetailLogViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import RealmSwift

class DetailLogViewController: UIViewController {
    
//MARK: Properties
    var date: Date?
    var moods: Results<DataEntry>?

    @IBOutlet weak var logTableView: UITableView!
    
    
//MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: Yay

}
