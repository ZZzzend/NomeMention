//
//  MainViewController.swift
//  Home Mention
//
//  Created by Владислав on 05/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    var reminders: Results<Reminder>!

    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.tableFooterView = UIView()
        
        reminders = realm.objects(Reminder.self)
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
