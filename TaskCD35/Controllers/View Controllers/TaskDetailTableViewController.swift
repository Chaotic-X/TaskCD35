//
//  TaskDetailTableViewController.swift
//  TaskCD35
//
//  Created by Alex Lundquist on 7/29/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
  
  //MARK: -Outlets
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var dueDateTextField: UITextField!
  @IBOutlet weak var noteTextView: UITextView!
  @IBOutlet var dueDatePicker: UIDatePicker!
  
  
  //MARK: -Properties
  var task: Task? {
    didSet {
      loadViewIfNeeded()
      updateView()
    }
  }
  var dueDate: Date?
  
  //MARK: -LifeCylce
  override func viewDidLoad() {
    super.viewDidLoad()
    dueDateTextField.inputView = dueDatePicker
  }
  
  //MARK: -Setup Functions and Helper Methods
  func updateView() {
    guard let task = task else { return }
    nameTextField.text = task.name
    noteTextView.text = task.notes
    dueDatePicker.date = task.dueDate ?? Date()
    dueDateTextField.text = dueDatePicker.date.stringValue()
    
  }
  
  func save() {
    guard let name = nameTextField.text,
      let due = dueDatePicker?.date,
      let notes = noteTextView.text,
      !name.isEmpty else { return }
    if let task = task {
      TaskController.sharedInstance.updateTask(updateWith: task, updateName: name, updateDate: due, updateNote: notes)
    } else {
      TaskController.sharedInstance.createTask(newTask: name, withNote: notes, withDate: due)
    }
    nameTextField.text = ""
    noteTextView.text = ""
    dueDateTextField.text = ""
    navigationController?.popViewController(animated: true)
  }
  
  //MARK: -Actions
  @IBAction func saveButtonTapped(_ sender: Any) {
    save()
  }
  @IBAction func cancelButtonTapped(_ sender: Any) {
    nameTextField.text = ""
    noteTextView.text = ""
    dueDateTextField.text = ""
    navigationController?.popViewController(animated: true)
  }
  @IBAction func datePickerDidChange(_ sender: UIDatePicker) {
    dueDate = sender.date
    dueDateTextField.text = dueDate?.stringValue()
  }
  @IBAction func userTappedView(_ sender: Any) {
    nameTextField.resignFirstResponder()
    dueDateTextField.resignFirstResponder()
    noteTextView.resignFirstResponder()
  }
}
