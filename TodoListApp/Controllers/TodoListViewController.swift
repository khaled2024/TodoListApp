//
//  TodoListViewController.swift
//  TodoListApp
//
//  Created by KhaleD HuSsien on 07/12/2021.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    //MARK: - variables
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - functions
 
    
    private func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        self.tableView.reloadData()
    }
    //MARK: - Actions
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write({
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    })
                }catch{
                    print("error of saving ")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - Extension UiTableViewDelegate
extension TodoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            // value = condition ? ValueIfTrue : ValueIfFalse
            cell.accessoryType = item.done ? .checkmark : .none
            
        }else{
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write({
                    item.done = !item.done
                })
            }catch{
                print("error of updating \(error)")
            }
        }
        self.tableView.reloadData()
        // here to didnt keeping selecting the cell after we select it
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
//MARK: - UISearchBarDelegate
extension TodoListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        self.tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}
