//
//  ViewController.swift
//  Todoey
//
//  Created by Dheeraj Kumar Sharma on 11/12/18.
//  Copyright © 2018 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
        
    }
    
    //MARK:- TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //MARK:- TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.saveItems()
        
        // inorder to add animated effect
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    
    //MARK:- Add New Item
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item for Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once user click add item button  UIAlert
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true , completion: nil)
        
    }
    
    //MARK:- Data Manipulation Method
    
    func saveItems(){
        do {
            try context.save()
        }catch{
            print("Error saving Contexr \(error )")
        }
        tableView.reloadData()
    }
    
    //MARK:- Loading Items
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest() , predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate , categoryPredicate])
        }else{
            request.predicate = categoryPredicate 
        }
        
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error in fetching \(error)")
        }
        tableView.reloadData()
        
    }
    
}

//MARK:- Search Bar methods

extension TodoListViewController: UISearchBarDelegate {
    
    //MARK:- Quering the data
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request :  NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text! )
        
        request.sortDescriptors = [NSSortDescriptor.init(key: "title", ascending: true)]
        
        loadItems(with: request , predicate: predicate)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0{
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            tableView.reloadData()
            
        }
    }
    
}

