//
//  MainViewController.swift
//  Home Mention
//
//  Created by Владислав on 05/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class MainViewController: UITableViewController {
    
   // let notify = UIApplication.shared.delegate as? Notification
    let notify = Notification()

    var reminders: Results<Reminder>!

    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().delegate = self
        
        reminders = realm.objects(Reminder.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.isEmpty ? 0 : reminders.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let reminder = reminders[indexPath.row]

         cell.textLabel?.text = reminder.name
         cell.detailTextLabel?.text = reminder.date
        
    //    notify.scheduleNotification(atDate: reminder.dater, title: reminder.name, identifier: reminder.identifier)
        return cell
    }
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let reminder = reminders[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { [weak self] (_, _) in
            StorageManager.deleteObject(reminder)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.notify.removeNotifications(withidentifiers: [reminder.identifier])
//            let reminder = self.reminders[indexPath.row]
//            let identificator = reminder.identifier
            
        }
        return [deleteAction]
    }


    
     // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let reminder = reminders[indexPath.row]
            let newReminderVC = segue.destination as! NewReminderTableViewController
            newReminderVC.currentReminder = reminder
        }
    }
    
    // MARK: - Save segue
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newReminderVC = segue.source as? NewReminderTableViewController else { return }
        
        newReminderVC.saveReminder()
//        reminders.append(newReminderVC.newReminder!)
        tableView.reloadData()
    }

}
