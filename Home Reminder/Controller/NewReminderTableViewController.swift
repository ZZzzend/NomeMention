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
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.view.endEditing(true)
//    }

//    class CustomTableView: UITableView {
//        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//            super.touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        endEditing(force: false)
//    }
//    }
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//            view.endEditing(true)
//
//    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            if indexPath.row == 1 || indexPath.row == 2 {
//
//            } else {
//                self.view.endEditing(true)
//            }
//
//            switch indexPath.row {
//            case 0:
//                self.view.endEditing(true)
//            case 1:
//                print("Hello")
//            default:
//                print("Hello")
//            }
        }
    
}
extension NewReminderTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
