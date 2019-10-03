//
//  Notice.swift
//  Home Mention
//
//  Created by Владислав on 18/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import Foundation
import UserNotifications

class Notification {
    
    func scheduleNotification(atDate date: Date?, title: String, identifier: String) {
        
           removeNotifications(withidentifiers: [identifier])
           
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
           let identifire = identifier
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
           
           let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze 10 minutes", options: [])
           let snoozeActionSecond = UNNotificationAction(identifier: "SnoozeSecond", title: "Snooze 1 hour", options: [])
           let snoozeActionThird = UNNotificationAction(identifier: "SnoozeThird", title: "Snooze 24 hours", options: [])
           let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
           let category = UNNotificationCategory(identifier: userAction,
                                           actions: [snoozeAction, snoozeActionSecond, snoozeActionThird, deleteAction], intentIdentifiers: [], options: [])
           notificationCenter.setNotificationCategories([category])
           
       }
    func removeNotifications(withidentifiers identifiers: [String]) {
         let center = UNUserNotificationCenter.current()
         center.removePendingNotificationRequests(withIdentifiers: identifiers)
     }
//       deinit {
//           removeNotifications(withidentifiers: [])
//    }
   
}

extension MainViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler:
      @escaping () -> Void) {
        switch response.actionIdentifier {
        case "Snooze":
            reschedule(response.notification, to: 10 * 60)
        case "SnoozeSecond":
            reschedule(response.notification, to: 60 * 60)
        case "SnoozeThird":
            reschedule(response.notification, to: 60 * 60 * 24)
        case "Delete":
            // Найти запись в Realm по идентификатору response.identifier
            break
          default:
             break
          }

           completionHandler()
        }

    private func reschedule(_ notification: UNNotification, to interval: TimeInterval) {
        let triggerSnooze = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: notification.request.identifier,
                                            content: notification.request.content,
                                            trigger: triggerSnooze)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let errorSnooze = error {
                print("Error \(errorSnooze.localizedDescription)")
            }
        }
        print("Snoozed \(interval) seconds")
    }
}
