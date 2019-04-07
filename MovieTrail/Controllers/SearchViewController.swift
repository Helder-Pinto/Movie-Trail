//
//  SearchViewController.swift
//  MovieTrail
//
//  Created by Apple on 31/03/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit


protocol CanReceive {
    func dataReceived(data: String)
}
class SearchViewController: UIViewController, UISearchBarDelegate {
    
    
    var delegate: CanReceive?
    
    @IBOutlet weak var seachField: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seachField.showsScopeBar = true
        seachField.delegate = self

        
    }
    

   
    @IBAction func searchTapped(_ sender: Any) {
        
        
        // make search request
        
        delegate?.dataReceived(data: seachField.text!)
        
        
        
       
    }
    
}
