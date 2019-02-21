//
//  ViewController.swift
//  ToDoToday&Ever
//
//  Created by Karolina on 19.02.2019.
//  Copyright © 2019 KarolinaLeg. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Model]()
    //let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
    }
    
    //MARK: załaduj dane użytkownika
    func retrieveData(){
       // print(dataFilePath)
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Model].self, from: data)
            }catch{
                print("Error decoding item \(error)")
            }
        }
      //  if let items = defaults.array(forKey: "TodoListArray2") as? [Model] {
      //  itemArray = items
      
//        newItem2.title = "Find cat"
//        newItem2.done =  true
//        itemArray.append(newItem2)
    }
    //MARK: wymagane funkcje
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        //ternary operator
        cell.accessoryType = item.done == true ? .checkmark : .none
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //MARK: zaznacz odznacz wiersz
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // zeby można było zaznaczyć więcej niż jedną, inaczej bdzie automatychnie wchodził do iddeselect przy zaznaczeniu innej komórki
        // zeby mieć tylko jedną zaznaczoną uzyj didSelectRowAt i didDeselectRowAt
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType  = .none
            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.saveItem()
       //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: add button
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textNewItem = UITextField()
        let alert = UIAlertController(title: "New todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // co się stanie po naciśnięciu "Add item"
            print("add btn pressed: ......  "+(textNewItem.text)!)
            let newItem = Model()
            newItem.title = textNewItem.text!
            self.itemArray.append(newItem)
          //  self.defaults.set(self.itemArray, forKey: "TodoListArray2")
         self.saveItem()
        }
        alert.addTextField { (alertTextField) in
            textNewItem = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: Model manipulation method
    func saveItem(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("Error encoding \(error)")
        }
        self.tableView.reloadData()
    }
    
}

