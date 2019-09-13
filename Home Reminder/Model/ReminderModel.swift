//
//  ReminderModel.swift
//  Home Mention
//
//  Created by Владислав on 12/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import RealmSwift

class Reminder: Object {
    var name: String
    var date: String?


// let ReminderCells = [String].self

static func getReminder() -> [Reminder] {
    
    var reminders = [Reminder]()
    return reminders
    
}
}
