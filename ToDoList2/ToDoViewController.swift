//
//  ToDoViewController.swift
//  ToDoList2
//
//  Created by Barbara Feinstein on 3/30/19.
//  Copyright © 2019 Barbara Feinstein. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
  var isDatePickerHidden = true
    var todo: ToDo?

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        case [0,1]:
            return isDatePickerHidden ? normalCellHeight : largeCellHeight
        case [1,0]:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,1]:
            isDatePickerHidden = !isDatePickerHidden
            dueDateLabel.textColor = isDatePickerHidden ? UIColor.black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        updateDueDateLabel(date: dueDatePickerView.date)
        
    }
    //Disable Save Button if user hasn't entered a title
    @IBAction func textEditingChanged(_ sender: Any) {
        
        updateSaveButtonState()
    }
    
    //Dismiss Keyboard on Return
    @IBAction func returnPressed(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    //switches button image to check mark when isCompleteButton is pressed
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
      
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
  

}
