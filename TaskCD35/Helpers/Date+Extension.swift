//
//  Date+Extension.swift
//  TaskCD35
//
//  Created by Alex Lundquist on 7/30/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation

extension Date {
  func stringValue() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: self)
  }
}
