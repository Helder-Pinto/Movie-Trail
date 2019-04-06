//
//  MyListViewController.swift
//  MovieTrail
//
//  Created by Apple on 06/04/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit
import CoreData

class MyListViewController: UITableViewController {
    
     var myMoviesArray = [Item]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
    }
    
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return myMoviesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListCell", for: indexPath)
        
        let item = myMoviesArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.watched ? .checkmark : .none
        
//        if item.watched == true {
//            cell.accessoryType = .checkmark
//
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
    }

    //MARK: -TableView delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         // remove items
//         context.delete(myMoviesArray[indexPath.row])
//         myMoviesArray.remove(at: indexPath.row)
        
        
        myMoviesArray[indexPath.row].watched = !myMoviesArray[indexPath.row].watched
        
        saveItems()
        
        tableView.deselectRow(at:indexPath, animated: true)
        
        
    }
    
    //MARK - Add New Items
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new movie", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
           
            
           
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.watched = false
            
            self.myMoviesArray.append(newItem)
            
             self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
           
        }
        
        
        alert.addAction(action)
        present(alert, animated:true, completion: nil)
        
       
        
        
    }
    
    
    //MARK: Core Data Saving support
    
    func saveItems(){
        
        do{
            try context.save()
        } catch{
            print("Erro saving context \(error)")
            
        }
        
        tableView.reloadData()
    }
    
    func loadItems (with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
        // let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
            myMoviesArray =   try   context.fetch(request)
            
        } catch {
            print("Error fetching data from context \(error)")
        }
        
    }
}



//MARK: Search

extension  MyListViewController : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
    }
    
    
    
    
}

