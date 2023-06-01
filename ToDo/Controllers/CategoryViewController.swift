//
//  TableViewController.swift
//  ToDo
//
//  Created by Damir Zaripov on 29.05.2023.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController {
    
    var categoryArray = [`Category`]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
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
        
        loadCategories()
        
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
                
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
            
        }
        alert.addTextField{ (field) in
            textField.placeholder = "Create new category"
            textField = field
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    func saveCategories() {
        
        let encoder = PropertyListEncoder()
                    
        do {
            try context.save()
        } catch {
            print("Error saving context - \(error)")
        }
        
        self.tableView.reloadData()
    }
        
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
            
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destination = ToDoListViewController()
        navigationController?.pushViewController(destination, animated: true)
        
    }
    
}
