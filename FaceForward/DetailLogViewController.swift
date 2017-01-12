//
//  DetailLogViewController.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-14.
//
//

import UIKit
import RealmSwift

class DetailLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//MARK: Properties
    var date: Date?
    var logs: [DataEntry] = []
    let realmManager = RealmManager()
    let backgroundImage = UIImage(named:"LowPolyForLogo")

    @IBOutlet weak var logTableView: UITableView!
    
    
//MARK: Other Stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logTableView.rowHeight = UITableViewAutomaticDimension
        logTableView.estimatedRowHeight = 250
        logTableView.backgroundView = UIImageView(image: backgroundImage)
        logTableView.backgroundView?.alpha = 0.2
        logTableView.backgroundView?.
        findLogs()
        
    }
    
    func findLogs() {
        for entry in realmManager.getSavedEntriesFromDatabase()! {
            let startOfDay = Calendar.current.startOfDay(for: entry.date)
            if startOfDay == date {
                self.logs.append(entry)
            } else {
                
            }
        }
    }
    
//MARK: TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let log = logs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailTableViewCell
        cell.configureCell(moods: log)
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return logs.count
    }
    
    
    

}
