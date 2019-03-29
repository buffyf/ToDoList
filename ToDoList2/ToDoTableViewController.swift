//
//  ToDoTableViewController.swift
//  ToDoList2
//
//  Created by Barbara Feinstein on 3/28/19.
//  Copyright © 2019 Barbara Feinstein. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var todos = [ToDo]()

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") else {
                fatalError("Could not dequeue a cell")
        }
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
        }
    }
    


