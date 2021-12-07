//
//  TodoListViewController.swift
//  TodoListApp
//
//  Created by KhaleD HuSsien on 07/12/2021.
//

import UIKit

class TodoListViewController: UITableViewController {
    let itemArray = ["khaled","hussien","khalifa"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    

}

