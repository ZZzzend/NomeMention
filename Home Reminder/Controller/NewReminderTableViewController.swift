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
    
    var currentReminder: Reminder?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var reminderName: UITextField!
    @IBOutlet weak var reminderDateCell: DatePickerCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reminderDateCell.leftLabel.text = "Select date"
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        reminderName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
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
    
    func saveReminder() {
        
        let newReminder = Reminder(name: reminderName.text!, date: reminderDateCell.rightLabel.text, dater: reminderDateCell.date)
        if currentReminder != nil {
            try! realm.write {
                currentReminder?.name = newReminder.name
                currentReminder?.date = newReminder.date
                currentReminder?.dater = newReminder.dater
                }
            } else {
                StorageManager.saveObject(newReminder)
        }

    }
    
    private func setupEditScreen() {
        if currentReminder != nil{
            setupNavigationBar()
            reminderName.text = currentReminder?.name
            reminderDateCell.rightLabel.text = currentReminder?.date
            reminderDateCell.date = currentReminder!.dater!
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentReminder?.name
        saveButton.isEnabled = true
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

