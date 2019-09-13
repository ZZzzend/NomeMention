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
    
    var newReminder: Reminder?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var reminderName: UITextField!
    @IBOutlet weak var reminderDateCell: DatePickerCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        saveButton.isEnabled = false
        
        reminderName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    // Высота DatePicker
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Get the correct height if the cell is a DatePickerCell.
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        // let cell = tableView.cellForRow(at: indexPath)
        if (cell is DatePickerCell) {
            return (cell as! DatePickerCell).datePickerHeight()
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    // Создает DatePicker в ячейке
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)
        if (cell is DatePickerCell) {
            let datePickerTableViewCell = cell as! DatePickerCell
            datePickerTableViewCell.selectedInTableView(tableView)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Скрывает клавиатуру при скролле
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    // Сохранение
    
    func saveNewReminder() {
//        let dateFormatter = reminderDateCell.rightLabel
        newReminder = Reminder(name: reminderName.text!, date: reminderDateCell.rightLabel.text)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

// Закрывает редактирование кнопкй done

extension NewReminderTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if reminderName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

