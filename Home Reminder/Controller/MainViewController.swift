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
    
    var notificationToken: NotificationToken? = nil
    
    let notify = Notification()

    var reminders: Results<Reminder>!

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        
        reminders = realm.objects(Reminder.self)
        notificationToken = reminders.observe { [weak self] (changes: RealmCollectionChange) in
        guard let tableView = self?.tableView else { return }
        switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
        case .update(_, let deletions, let insertions, let modifications):
            tableView.beginUpdates()
            tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                 with: .automatic)
            tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                 with: .automatic)
            tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                 with: .automatic)
            tableView.endUpdates()
            case .error(let error):
            fatalError("\(error)")
    }
    }
    }
//    deinit {
 //       notificationToken?.invalidate()
  //  }
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
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete".localized) { [weak self] (_, _) in
            self?.notify.removeNotifications(withidentifiers: [reminder.identifier])
            StorageManager.deleteObject(reminder)
         //   tableView.reloadData()
          //  tableView.deleteRows(at: [indexPath], with: .automatic)
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
//        tableView.reloadData()
    }

}
