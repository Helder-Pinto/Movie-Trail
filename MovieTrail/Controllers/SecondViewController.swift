//
//  SecondViewController.swift
//  MovieTrail
//
//  Created by Apple on 29/03/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit
import Alamofire

class SecondViewController: UIViewController {
    
    
    //Outlets
   
    @IBOutlet weak var movieTitleField: UILabel!
    @IBOutlet weak var moviePosterField: UIImageView!
    
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieAverage: UILabel!
    
    
    var movieTitle: String = ""
    var posterImage: UIImage!
    var movieOverviewText: String = ""
    var movieFotoUrl: String = ""
    //var movieRatings: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleField.text = movieTitle
        movieOverview.text = movieOverviewText
        print(movieOverviewText)
        miniPoster()
       
        }
    
    @IBAction func addFavsButton(_ sender: Any) {
        
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
}
