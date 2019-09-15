//
//  ReminderModel.swift
//  Home Mention
//
//  Created by Владислав on 12/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import RealmSwift

class Reminder: Object {
    @objc dynamic var name: String
    @objc dynamic var date: String?


// let ReminderCells = [String].s elf

//    func getReminder() -> [Reminder] {
//
//        var reminders = [Reminder]()
//        return reminders
//
//}
    
    convenience init(name: String, date: String?){
        self.init()
        self.name = name
        self.date = date
    }
}
