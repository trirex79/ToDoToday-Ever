//
//  ViewController.swift
//  ToDoToday&Ever
//
//  Created by Karolina on 19.02.2019.
//  Copyright © 2019 KarolinaLeg. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find keys", "Buy apples", "Call doctor", "Kill dragon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: wymagane funkcje
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //MARK: zaznacz odznacz wiersz
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // zeby można było zaznaczyć więcej niż jedną, inaczej bdzie automatychnie wchodził do iddeselect przy zaznaczeniu innej komórki
        // zeby mieć tylko jedną zaznaczoną uzyj didSelectRowAt i didDeselectRowAt
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType  = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: add button
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textNewItem = UITextField()
        let alert = UIAlertController(title: "New todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // co się stanie po naciśnięciu "Add item"
            print("add btn pressed: ......  "+(textNewItem.text)!)
            self.itemArray.append(textNewItem.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            textNewItem = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

