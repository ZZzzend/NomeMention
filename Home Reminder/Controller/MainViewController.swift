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
    
    var reminders: Results<Reminder>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminders = realm.objects(Reminder.self)
    }
    
    func scheduleNotification(atDate date: Date?, title: String) {
        
        let content = UNMutableNotificationContent()
        let notificationCenter = UNUserNotificationCenter.current()
        let userAction = "UserAction"
        
            content.subtitle = "Home Reminder:"
            content.body = title
            content.sound = UNNotificationSound.default
            content.categoryIdentifier = userAction
        
        let dater = date
        let triggerDate = Calendar.current.dateComponents( [.year,.month,.day,.hour,.minute,], from: dater!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let identifire = "Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        print("все прошло успешно")
        //   UNUserNotificationCenter.add
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze 5 minute", options: [])
        let snoozeActionSecond = UNNotificationAction(identifier: "SnoozeSecond", title: "Snooze 1 hour", options: [])
        let snoozeActionThird = UNNotificationAction(identifier: "SnoozeThird", title: "Snooze 1 day", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: userAction,
                                        actions: [snoozeAction, snoozeActionSecond, snoozeActionThird, deleteAction], intentIdentifiers: [], options: [])
        notificationCenter.setNotificationCategories([category])
        
//        func userNotificationCenter(_ center: UNUserNotificationCenter,
//        didReceive response: UNNotificationResponse,
//        withCompletionHandler completionHandler:
//          @escaping () -> Void) {
//            
//            switch response.actionIdentifier {
//              case "Snooze":
//
//                content.body = "Opps"
//                let triggerSnooze = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                let request = UNNotificationRequest(identifier: identifire,
//                                                    content: content,
//                                                    trigger: triggerSnooze)
//                notificationCenter.add(request) { (error) in
//                if let errorSnooze = error {
//                    print("Error \(errorSnooze.localizedDescription)")
//                }
//                }
//                print("Snooze")
//
//
//              case "SnoozeSecond":
//
//                  break
//
//              case "SnoozeThird":
//
//                  break
//
//              case "Delete":
//
//                  break
//
//              default:
//                 break
//              }
//
//               completionHandler()
//            }
        
//        func userNotificationCenter(_ center: UNUserNotificationCenter,
//        didReceive response: UNNotificationResponse,
//        withCompletionHandler completionHandler:
//          @escaping () -> Void) {
//
//            switch response.actionIdentifier {
//              case "Snooze":
//
//                content.body = "Opps"
//                let triggerSnooze = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                let request = UNNotificationRequest(identifier: identifire,
//                                                    content: content,
//                                                    trigger: triggerSnooze)
//                notificationCenter.add(request) { (error) in
//                if let errorSnooze = error {
//                    print("Error \(errorSnooze.localizedDescription)")
//                }
//                }
//                print("Snooze")
//
//
//              case "SnoozeSecond":
//
//                  break
//
//              case "SnoozeThird":
//
//                  break
//
//              case "Delete":
//
//                  break
//
//              default:
//                 break
//              }
//
//               completionHandler()
//            }
    }
    


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminders.isEmpty ? 0 : reminders.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let reminder = reminders[indexPath.row]

         cell.textLabel?.text = reminder.name
         cell.detailTextLabel?.text = reminder.date
        
        scheduleNotification(atDate: reminder.dater, title: reminder.name)
        
        return cell
    }
    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let reminder = reminders[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.deleteObject(reminder)
            tableView.deleteRows(at: [indexPath], with: .automatic)
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
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newReminderVC = segue.source as? NewReminderTableViewController else { return }
        
        newReminderVC.saveReminder()
//        reminders.append(newReminderVC.newReminder!)
        tableView.reloadData()
    }

}

//extension AppDelegate: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .sound])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//    didReceive response: UNNotificationResponse,
//    withCompletionHandler completionHandler:
//      @escaping () -> Void) {
//
//        switch response.actionIdentifier {
//          case "Snooze":
//
//            content.body = "Opps"
//            let triggerSnooze = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//            let request = UNNotificationRequest(identifier: identifire,
//                                                content: content,
//                                                trigger: triggerSnooze)
//            notificationCenter.add(request) { (error) in
//            if let errorSnooze = error {
//                print("Error \(errorSnooze.localizedDescription)")
//            }
//            }
//            print("Snooze")
//
//
//          case "SnoozeSecond":
//
//              break
//
//          case "SnoozeThird":
//
//              break
//
//          case "Delete":
//
//              break
//
//          default:
//             break
//          }
//
//           completionHandler()
//        }
//}
