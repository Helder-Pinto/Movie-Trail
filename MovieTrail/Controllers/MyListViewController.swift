//
//  MyListViewController.swift
//  MovieTrail
//
//  Created by Apple on 06/04/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit

class MyListViewController: UITableViewController {
    
    
    var myMoviesArray = ["Us", "Wolf Of WallStreet", "Blood Diamonds"]

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return myMoviesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListCell", for: indexPath)
        cell.textLabel?.text = myMoviesArray[indexPath.row]
        return cell
    }

    //MARK: -TableView delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // if tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark ? .none : .checkmark
       
        
        tableView.deselectRow(at:indexPath, animated: true)
        
        
    }
    
    //MARK - Add New Items
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new movie", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
           
            self.myMoviesArray.append(textField.text!)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
           
        }
        
        
        alert.addAction(action)
        present(alert, animated:true, completion: nil)
        
        
    }
    
}
