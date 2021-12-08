//
//  CategoryViewController.swift
//  TodoListApp
//
//  Created by KhaleD HuSsien on 08/12/2021.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
//MARK: - variables
    var categoryArr = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        
    }
//MARK: - Functions
    private func saveCategory(){
          do{
              try context.save()
          }catch{
             print("Error saving context \(error)")
          }
        self.tableView.reloadData()
    }
    private func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categoryArr = try context.fetch(request)
        }
        catch{
            print("Error for feching Item \(error)")
        }
        self.tableView.reloadData()
    }
    
    
//MARK: - Actions
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert  = UIAlertController(title: "Add To-do Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categoryArr.append(newCategory)
            self.saveCategory()
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
        return categoryArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArr[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let index = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArr[index.row]
        }
    }
}
