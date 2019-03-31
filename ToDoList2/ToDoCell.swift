//
//  File.swift
//  ToDoList2
//
//  Created by Barbara Feinstein on 3/30/19.
//  Copyright © 2019 Barbara Feinstein. All rights reserved.
//

import UIKit
@objc protocol ToDoCellDelegate: class{
    func checkmarkTapped(sender: ToDoCell)
}
class ToDoCell: UITableViewCell {
    var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    
    @IBAction func completeButtonTapped(_ sender: Any) {
    delegate?.checkmarkTapped(sender: self)
    }
    
}
