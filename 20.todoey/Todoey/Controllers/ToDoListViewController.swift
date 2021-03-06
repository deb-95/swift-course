//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController {
    var items: Results<RealmToDoItem>?
    var selectedCategory: RealmCategory? {
        didSet {
            loadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentCategory = selectedCategory {
            title = currentCategory.name
            let color = UIColor(hexString: currentCategory.color)
            navigationController?.navigationBar.barTintColor = color
            navigationController?.navigationBar.backgroundColor = color
            navigationController?.navigationBar.tintColor = ContrastColorOf(color!, returnFlat: true)
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: ContrastColorOf(color!, returnFlat: true)]
            searchBar.barTintColor = color
        }
    }
    
    // MARK: - Table View Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let toDoItem = items?[indexPath.row]
        cell.textLabel?.text = toDoItem?.content ?? "No items added yet"
        cell.accessoryType = toDoItem?.checked ?? false ? .checkmark : .none
        
        if let currentCategory = selectedCategory {
            if let color = UIColor(hexString: currentCategory.color)?.darken(byPercentage: CGFloat(getDarkenPercentage(for: indexPath.row))) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
        }
        return cell
    }
    
    func getDarkenPercentage(for indexPathRow: Int) -> CGFloat {
        return CGFloat(indexPathRow) / CGFloat(items!.count)
    }
    
    // MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = items else { return }
        do {
            try realm.write {
                items[indexPath.row].checked = !items[indexPath.row].checked
            }
        } catch {
            print("Error toggling done status. \(error)")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func onAddPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let text = textField.text {
                let item = RealmToDoItem()
                item.content = text
                item.dateCreated = Date()
                self.save(item: item)
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Utility Functions
    func save(item: RealmToDoItem) {
        if let currentCategory = self.selectedCategory {
            do {
                try self.realm.write {
                    currentCategory.items.append(item)
                }
            } catch {
                print("error saving data to realm. \(error)")
            }
        }
        
        self.tableView.reloadData()
    }
    
    //    func loadData(with request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest(), predicate: NSPredicate? = nil) {
    //        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", self.selectedCategory!.name!)
    //
    //        if let additionalPredicate = predicate {
    //            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate, categoryPredicate])
    //            request.predicate = compoundPredicate
    //        } else {
    //            request.predicate = categoryPredicate
    //        }
    //
    //        do {
    //            self.items = try context.fetch(request)
    //        } catch {
    //            print("Error fetching data from context. \(error)")
    //        }
    //        self.tableView.reloadData()
    //    }
    
    func loadData() {
        items = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    override func delete(at indexPath: IndexPath) {
        if let item = self.items?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("Error while deleting category. \(error)")
            }
        }
    }
}

//MARK: - SearchBar methods
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
//        let predicate = NSPredicate(format: "content CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "content", ascending: true)]
        items = items?.filter("content CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        self.tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
