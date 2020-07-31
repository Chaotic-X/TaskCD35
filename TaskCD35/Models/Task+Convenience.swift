//
//  Task+Convenience.swift
//  TaskCD35
//
//  Created by Alex Lundquist on 7/29/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation
import CoreData

extension Task {
  
  convenience init(name: String, dueDate: Date, notes: String, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
    self.init(context: context)
    self.name = name
    self.dueDate = dueDate
    self.notes = notes
    self.isComplete = isComplete
  }
}
