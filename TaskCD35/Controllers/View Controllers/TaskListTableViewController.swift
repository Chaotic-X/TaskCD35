//
//  TaskListTableViewController.swift
//  TaskCD35
//
//  Created by Alex Lundquist on 7/29/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
  
  //MARK: -Outlets
  
  //MARK: -Properties
  
  //MARK: -LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    TaskController.sharedInstance.fetchedResultsController.delegate = self
  } //End of ViewDidLoad
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return TaskController.sharedInstance.fetchedResultsController.sections?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return TaskController.sharedInstance.fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return TaskController.sharedInstance.fetchedResultsController.sectionIndexTitles[section] == "0" ? "Keep at it Slacker" : "Completed Tasks"
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskListCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
    let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
    cell.task = task
    cell.delegate = self
    return cell
  }
  
  
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let taskToDelete = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
      TaskController.sharedInstance.deleteTask(taskToDelete: taskToDelete)
    }
  }
  
  // MARK: - Navigation
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetailVC"{
      guard let indexPath = tableView.indexPathForSelectedRow,
        let destinationVC = segue.destination as? TaskDetailTableViewController else { return }
      let taskToSend = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
      destinationVC.task = taskToSend
    }
  }
} //End of Class

//MARK: -Extesion
extension TaskListTableViewController: ButtonTableViewCellDelegate {
  func isCompleteButtonChanged(for cell: ButtonTableViewCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
    TaskController.sharedInstance.toggelIsComplete(task: task)
    cell.updateCell()
  }
}

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    switch type {
      case .insert:
        let indexSet = IndexSet(integer: sectionIndex)
        tableView.insertSections(indexSet, with: .automatic)
      case .delete:
        let indexSet = IndexSet(integer: sectionIndex)
        tableView.deleteSections(indexSet, with: .automatic)
      default:
        fatalError()
    }
  }
  //The options we have access to by using NSFetchedResultsContoller
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
      case .delete:
        guard let indexPath = indexPath else { break }
        tableView.deleteRows(at: [indexPath], with: .fade)
      case .insert:
        guard let newIndexPath = newIndexPath else { break }
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      case .move:
        guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
        tableView.moveRow(at: indexPath, to: newIndexPath)
      case .update:
        guard let indexPath = indexPath else { break }
        tableView.reloadRows(at: [indexPath], with: .automatic)
      @unknown default:
        fatalError()
    }
  }
}
