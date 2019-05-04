//
//  MyListViewController.swift
//  MovieTrail
//
//  Created by Apple on 06/04/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class MyListViewController: UITableViewController{
    
     var myMoviesArray = [Item]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        tableView.rowHeight = 90.0
        
    }
    
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return myMoviesArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListCell", for: indexPath) as! SwipeTableViewCell
        
        let item = myMoviesArray[indexPath.row]
        
        cell.textLabel?.text = item.title
            cell.delegate = self

        cell.imageView?.image = UIImage(data: item.image!)
        
        
        
        
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
        // context.delete(myMoviesArray[indexPath.row])
         //myMoviesArray.remove(at: indexPath.row)
        
        
         myMoviesArray[indexPath.row].watched = !myMoviesArray[indexPath.row].watched
        
        saveItems()
        
        tableView.deselectRow(at:indexPath, animated: true)
        
        
    }
    //MARK - Swipe Cell Delegate Methoda
    
    
    
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
        
     
        
        do{
            myMoviesArray =   try   context.fetch(request)
            
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}



//MARK: Search

extension  MyListViewController : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate  = NSPredicate(format: "title CONTAINS [cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
         loadItems (with: request)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
           
        }
    }
    
}

//MARK - Swipe Cell Delegate Methoda

extension MyListViewController: SwipeTableViewCellDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            

            // remove items
            
            
            
                    self.myMoviesArray.remove(at: indexPath.row)
                        print("removed drom array")
                    //self.saveItems()
            
                    //tableView.reloadData()
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }

   func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation:   SwipeActionsOrientation) -> SwipeOptions {
        self.context.delete(self.myMoviesArray[indexPath.row])
        do{
            try context.save()
        } catch{
            print("Erro saving context \(error)")
            
        }
        print("deleted from context")
    
        var options = SwipeOptions()
         options.expansionStyle = .destructive
        print("destroyed")

        return options
    }
    
    @IBAction func unwindLocationCancel(segue:UIStoryboardSegue) {}



}

