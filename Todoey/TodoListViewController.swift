//
//  ViewController.swift
//  Todoey
//
//  Created by Dheeraj Kumar Sharma on 11/12/18.
//  Copyright © 2018 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy eggs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- TableView DataSource Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //MARK:- TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //Adding accessory (Checkmark)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType =  .checkmark
        }
        
        // inorder to add animated effect
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

