//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Debora Del Vecchio on 10/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    var categories: Results<RealmCategory>?
    
    //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.flatBlue()
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let categoryName = textField.text {
                let newCategory = RealmCategory()
                newCategory.name = categoryName
                newCategory.color = UIColor.randomFlat().hexValue()
                self.save(category: newCategory)
            }
        }
        alert.addAction(action)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Insert Category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let category = categories?[indexPath.row]
        let color = UIColor(hexString: category?.color ?? UIColor.flatBlue().hexValue())
        cell.textLabel?.text = category?.name ?? "No categories added yet"
        cell.accessoryType = category?.name != nil ? .disclosureIndicator : .none
        cell.backgroundColor = color
        cell.textLabel?.tintColor = ContrastColorOf(color!, returnFlat: true)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    // MARK: - Data manipulation methods
    
    //    func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
    //        do {
    //            categories = try context.fetch(request)
    //        } catch {
    //            print("Error while loading data. \(error)")
    //        }
    //        self.tableView.reloadData()
    //    }
    
    func loadData() {
        categories = realm.objects(RealmCategory.self)
        tableView.reloadData()
    }
    
    func save(category: RealmCategory) {
        do {
            try realm.write() {
                realm.add(category)
            }
        } catch {
            print("Error while saving data. \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let category = categories?[indexPath.row]
            destinationVC.selectedCategory = category
        }
    }
    
    override func delete(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
            } catch {
                print("Error while deleting category. \(error)")
            }
        }
    }
}
