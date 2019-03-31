//
//  ToDoViewController.swift
//  ToDoList2
//
//  Created by Barbara Feinstein on 3/30/19.
//  Copyright © 2019 Barbara Feinstein. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    var isDatePickerHidden = true
    var todo: ToDo?
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
 
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    //Disable Save Button if user hasn't entered a title
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    //Dismiss Keyboard on Return
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    //switches button image to check mark when isCompleteButton is pressed
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDatePickerView.minimumDate = Date()
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        switch indexPath {
        case [1,0]:
            return isDatePickerHidden ? normalCellHeight : largeCellHeight
        case [2,0]:
            return largeCellHeight
        default: return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]:
            isDatePickerHidden = !isDatePickerHidden
            dueDateLabel.textColor = isDatePickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default:break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        
    }
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    
    
    
  

}
