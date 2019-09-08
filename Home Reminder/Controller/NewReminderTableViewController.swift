//
//  NewReminderTableViewController.swift
//  Home Mention
//
//  Created by Владислав on 08/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import UIKit

class NewReminderTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 1 || indexPath.row == 2 {
//        } else {
//            view.endEditing(true)
//        }
//    }

}
extension NewReminderTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
