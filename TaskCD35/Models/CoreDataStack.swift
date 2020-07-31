//
//  CoreDataStack.swift
//  TaskCD35
//
//  Created by Alex Lundquist on 7/29/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
static let container: NSPersistentContainer = {
  let container = NSPersistentContainer(name: "TaskCD35")
  container.loadPersistentStores { (storeDescription, error) in
    if let error = error as NSError? {
      fatalError("Unresolved Error \(error), \(error.userInfo)")
    }
  }
  return container
}()
static var context: NSManagedObjectContext { return container.viewContext }
}
