//
//  ButtonTableViewCell.swift
//  TaskCD35
//
//  Created by Alex Lundquist on 7/29/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
  func isCompleteButtonChanged(for cell: ButtonTableViewCell)
}
class ButtonTableViewCell: UITableViewCell {
  
  //MARK: -Outlets
  @IBOutlet weak var isCompleteButton: UIButton!
  @IBOutlet weak var taskNameLabel: UILabel!
  
  //MARK: -Properties
  var task: Task? {
    didSet{
      updateCell()
      reloadInputViews()
    }
  }
  var delegate: ButtonTableViewCellDelegate?

  //MARK: -Actions
  @IBAction func isCompleteButtonTapped(_ sender: Any) {
    delegate?.isCompleteButtonChanged(for: self)
  }
  
  //MARK: -Helper Methods
  func updateCell() {
    guard let task = task else { return }
    taskNameLabel.text = task.name
    updateButton(for: task)
  }
  
  func updateButton(for task: Task) {
    let checkSymbolConfig = UIImage.SymbolConfiguration(pointSize: 24.0, weight: .bold, scale: .large)
    let squareSymbolConfig = UIImage.SymbolConfiguration(pointSize: 24.0, weight: .bold, scale: .large)
    let completeImage = UIImage(systemName: "checkmark.square" , withConfiguration: checkSymbolConfig)
    let inCompleteImage = UIImage(systemName: "square", withConfiguration: squareSymbolConfig)

    task.isComplete ? isCompleteButton.setImage(completeImage, for: .normal) : isCompleteButton.setImage(inCompleteImage, for: .normal)
  }
}
/**
 refernce code to use to use this image:
 https://www.hackingwithswift.com/example-code/uikit/how-to-use-system-icons-in-your-app
 system symbol -> square
 system symbol -> checkmark.square
 ie: let paperPlane = UIImage(systemName: "paperplane.fill") <- calling the symbol
 let action = UIImage(systemName: "square.and.arrow.down") <- calling the symbol
 let boldConfig = UIImage.SymbolConfiguration(weight: .bold) <- setting symbol weight
 let boldBell = UIImage(systemName: "bell", withConfiguration: boldConfig) <- setting symbol weight
 let largeConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle) <- Setting the textStyle vs font point size
 let largeBolt = UIImage(systemName: "bolt", withConfiguration: largeConfig) <- calling that object
*/
