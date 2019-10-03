//
//  ReminderModel.swift
//  Home Mention
//
//  Created by Владислав on 12/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import RealmSwift

class Reminder: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var date: String?
    @objc dynamic var dater: Date?
    @objc dynamic var identifier: String = ""

    
    convenience init(name: String, date: String?, dater: Date?, identifier: String) {
        self.init()
        self.name = name
        self.date = date
        self.dater = dater
        self.identifier = identifier
    }
}
