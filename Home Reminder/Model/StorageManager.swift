//
//  StorageManager.swift
//  Home Mention
//
//  Created by Владислав on 14/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Reminder) {
        
        try! realm.write {
            realm.add(reminder)
        }
    }
}

