//
//  AppDelegate.swift
//  Home Mention
//
//  Created by Владислав on 05/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()
    
//    let mainViewController = MainViewController()
//    init(mainViewController: MainViewController = MainViewController()) {
//        self.MainViewController = mainViewController
//    }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAutorisation()
        notificationCenter.delegate = self
        return true
    }
    
    func requestAutorisation() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSetings()
        }
    }
    
    func getNotificationSetings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler:
      @escaping () -> Void) {
        
        switch response.actionIdentifier {
          case "Snooze":
            // let mainViewController = UIApplication.shared.delegate as! MainViewController
            content.body = "Opps"
            let triggerSnooze = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: identifire,
                                                content: content,
                                                trigger: triggerSnooze)
            notificationCenter.add(request) { (error) in
            if let errorSnooze = error {
                print("Error \(errorSnooze.localizedDescription)")
            }
            }
            print("Snooze")


          case "SnoozeSecond":

              break

          case "SnoozeThird":

              break

          case "Delete":

              break

          default:
             break
          }

           completionHandler()
        }
}
