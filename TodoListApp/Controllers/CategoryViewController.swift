//
//  CategoryViewController.swift
//  TodoListApp
//
//  Created by KhaleD HuSsien on 08/12/2021.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
//MARK: - variables
    
    let realm = try! Realm()
    var categories: Results<Category>!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let navBar = navigationController?.navigationBar{
            navBar.tintColor = UIColor(hexString: "2468A3")
            if let colorHex = UIColor(hexString: "2468A3") {
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : colorHex]
                navBar.barTintColor = colorHex
            }
        }
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
    
//    override from super class (SwipeTableViewController)
    override func updateModel(at indexPath: IndexPath) {
            if let categroyForDeletion = self.categories?[indexPath.row]{
                do {
                    try self.realm.write({
                        self.realm.delete(categroyForDeletion)
                    })
                } catch  {
                    print("Error for deleting category")
                }
            }
    }
    

    
//MARK: - Actions
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert  = UIAlertController(title: "Add To-do Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
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
//MARK: - Extensions UiTableViewDelegate
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let category = categories?[indexPath.row]{
            cell.textLabel?.text = category.name
            cell.backgroundColor = UIColor(hexString: category.color)
            cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: category.color)!, returnFlat: true)
        }
        
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
