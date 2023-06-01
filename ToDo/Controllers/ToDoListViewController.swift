//
//  TableViewController.swift
//  ToDo
//
//  Created by Damir Zaripov on 29.05.2023.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(ToDoItemCell.self, forCellReuseIdentifier: "ToDoItemCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var addButton: UIBarButtonItem = {
        var button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        button.tintColor = UIColor.blue
        return button
    }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        loadItems()
        
        view.backgroundColor = .systemCyan
        
        view.addSubview(tableView)
        
        navigationController?.navigationBar.backgroundColor = .systemCyan
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        

        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func addButtonPressed() {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
                    
        do {
            try context.save()
        } catch {
            print("Error saving context - \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
           itemArray = try context.fetch(request)
        } catch {
            print("Error fetching context - \(error)")
        }
    }
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
                
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
                
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
