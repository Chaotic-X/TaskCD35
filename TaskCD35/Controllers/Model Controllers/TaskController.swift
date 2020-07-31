//
//  TaskController.swift
//  TaskCD35
//
//  Created by Alex Lundquist on 7/29/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
  
  static let sharedInstance = TaskController()
  //MARK: -Source of Truth
  var fetchedResultsController: NSFetchedResultsController<Task>
  init(){
    //    self.tasks = fetchTasks()
    /// Creating a request of the Type NSFetchRequest to get our Task objects
    /// Then setting that to Task.fetchRequest()
    let request: NSFetchRequest<Task> = Task.fetchRequest()
    /// we call .sortDescriptors and set that to how we want our results to be sorted when the request returns our Task objects
    request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true)]
    /// defining/Initializing a fetchedResultsController using the request which we defined above, passing in our CoreDataStack.context and setting sectionNameKeyPath and cacheName to nil
    let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
    ///Initilize the Source of Truth with our resultsController
    fetchedResultsController = resultsController
    //Do catch block
    do{
    // Calling the performFetfch method on our FRC to do the request
      try fetchedResultsController.performFetch()
    } catch {
      print("The CoreData Model Blew up and nothing came back")
    }
    
  } //End of the Init

  //MARK: -Helper Function
  func toggelIsComplete(task: Task) {
    task.isComplete.toggle()

    saveToPersistentStore()
  }
  //MARK: -CRUD
  //create
  func createTask(newTask taskName: String, withNote note: String, withDate date: Date) {
    _ = Task(name: taskName, dueDate: date, notes: note)
    saveToPersistentStore()
  }
  
  //Read - not today biatch
  //Udate
  func updateTask(updateWith task: Task, updateName withName: String, updateDate withDate: Date, updateNote withNote: String) {
    task.name = withName
    task.dueDate = withDate
    task.notes = withNote
    saveToPersistentStore()
  }
  
  //Delete
  func deleteTask(taskToDelete removeTask: Task) {
    if let moc = removeTask.managedObjectContext {
      moc.delete(removeTask)
      saveToPersistentStore()
    }
  }
  
  //MARK: -Persistent Store - CoreData
  //Save to CoreData
  func saveToPersistentStore() {
    let moc = CoreDataStack.context
    do {
      try moc.save()
    } catch let saveError {
      print("There was a problem saving to CoreData: \(saveError)")
    }
  }
  //Load will come with Fetched Results
  
} //End of TaskController Class
