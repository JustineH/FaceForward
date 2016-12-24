//
//  RealmManager.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-23.
//
//

import UIKit
import RealmSwift

class RealmManager: NSObject {
    
    func getSavedEntriesFromDatabase() -> Results<DataEntry>?{
        let realm = try! Realm()
        return realm.objects(DataEntry.self)
    }
}
