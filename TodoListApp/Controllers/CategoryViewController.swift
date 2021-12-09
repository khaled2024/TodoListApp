//
//  CategoryViewController.swift
//  TodoListApp
//
//  Created by KhaleD HuSsien on 08/12/2021.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
//MARK: - variables
    
    let realm = try! Realm()
    var categories: Results<Category>!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        
    }
//MARK: - Functions
    private func save(category: Category){
          do{
              try realm.write({
                  realm.add(category)
              })
          }catch{
             print("Error saving context \(error)")
          }
        self.tableView.reloadData()
    }
    private func loadCategory(){
         categories = realm.objects(Category.self)
        self.tableView.reloadData()
    }

    
//MARK: - Actions
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert  = UIAlertController(title: "Add To-do Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add Category"
            textField = alertTextField
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - Extensions
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category added yet"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let index = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[index.row]
        }
    }
}
