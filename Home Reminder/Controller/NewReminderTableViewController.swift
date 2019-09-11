//
//  NewReminderTableViewController.swift
//  Home Mention
//
//  Created by Владислав on 08/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import UIKit
import DatePickerCell


class NewReminderTableViewController: UITableViewController {
    var cells = [[UIView]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        let datePickerCell = DatePickerCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        // Cells is a 2D array containing sections and rows.
        
        cells = [[datePickerCell]]

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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Get the correct height if the cell is a DatePickerCell.
        let cell = cells
        if (cell is DatePickerCell) {
            return (cell as! DatePickerCell).datePickerHeight()
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 1 {
                let cell = self.tableView.cellForRow(at: indexPath)
                if (cell is DatePickerCell) {
                    let datePickerTableViewCell = cell as! DatePickerCell
                    datePickerTableViewCell.selectedInTableView(tableView)
                    self.tableView.deselectRow(at: indexPath, animated: true)
                }
            }
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
