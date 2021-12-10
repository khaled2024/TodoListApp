//
//  SwipeTableViewController.swift
//  TodoListApp
//
//  Created by KhaleD HuSsien on 10/12/2021.
//

import UIKit
import SwipeCellKit
class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70.0
        tableView.separatorStyle = .none
    }
    
    //MARK: - functions
    
    func updateModel(at indexPath: IndexPath){
        // sup class
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! SwipeTableViewCell
                cell.delegate = self
                return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.updateModel(at: indexPath)
            }
            // customize the action appearance
            deleteAction.image = UIImage(systemName: "trash")
            return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }

}
