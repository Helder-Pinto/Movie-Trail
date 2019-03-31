//
//  SecondViewController.swift
//  MovieTrail
//
//  Created by Apple on 29/03/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit



class SecondViewController: UIViewController {
    
    
    //Outlets
   
    @IBOutlet weak var movieTitleField: UILabel!
    @IBOutlet weak var moviePosterField: UIImageView!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieAverage: UILabel!
    
    
    var movieTitle: String = ""
    var posterImage: UIImage!
    var movieOverviewText: String = ""
    //var movieRatings: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleField.text = movieTitle
        movieOverview.text = movieOverviewText
        moviePosterField.image = posterImage
        
        //movieAverage.text = movieRatings
        
      
    }
    
    @IBAction func addFavsButton(_ sender: Any) {
        
        navigateToTableView()
        
        
    }
    
    private func navigateToTableView (){
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let tableVC = mainStoryboard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController else {
            return
        }
        present(tableVC, animated: true, completion: nil)
    }
    
  
}
