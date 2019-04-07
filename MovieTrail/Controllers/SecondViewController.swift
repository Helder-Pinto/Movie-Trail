//
//  SecondViewController.swift
//  MovieTrail
//
//  Created by Apple on 29/03/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class SecondViewController: UIViewController {
    
    
    //Outlets
   
    @IBOutlet weak var movieTitleField: UILabel!
    @IBOutlet weak var moviePosterField: UIImageView!
    
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieAverage: UILabel!
    
    var myMoviesArray2 = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var movieTitle: String = ""
    var posterImage: UIImage!
    var movieOverviewText: String = ""
    var movieFotoUrl: String = ""
    //var movieRatings: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleField.text = movieTitle
        movieOverview.text = movieOverviewText
        miniPoster()
       
        }

    
    
    
    func miniPoster (){
        Alamofire.request(movieFotoUrl).responseImage(completionHandler: {
            (response) in
            if let image = response.result.value {
                let size = CGSize(width: 140, height: 200)
                let scaledImage = image.af_imageScaled(to:  size).af_imageRounded(withCornerRadius: 3.0)
                DispatchQueue.main.async { self.moviePosterField.image = scaledImage
                }
            }
        })
        }
    
    
    //MARK prepare and send data to mylist
    
    
    @IBAction func addFavsButton(_ sender: Any) {
        
        let newItem = Item(context: self.context)
        
        newItem.title = movieTitle
        newItem.watched = false
        
        //myMoviesArray2.append(newItem)
        
       // func saveItems(){
            
            do{
                try context.save()
            } catch{
                print("Erro saving context \(error)")
                
            }
            
            
      //  }
        
       // performSegue(withIdentifier: "goToList", sender: self)
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToList" {
//
//            let myListVC = segue.destination as! MyListViewController
//
//
//
//        }
//
//    }
}
