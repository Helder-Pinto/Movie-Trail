//
//  ViewController.swift
//  MovieTrail
//
//  Created by Helder Pinto on 29/03/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class ViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, CanReceive  {
    
    //Variables
  
    let MOVIE_URL = "https://api.themoviedb.org/3/discover/movie?api_key=0abf1befdf259f8b383017249ba19a9a&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
  
    var movieData = [[String: AnyObject]]()
    
    
    
    
    //IBoutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        getMovieData(url: MOVIE_URL)
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/3, height: (self.collectionView.frame.size.height)/4)
        
    }
    
    
    
    //Networking
    
  func getMovieData(url: String){
        
        Alamofire.request(url, method: .get).responseJSON {
         response in
            if response.result.isSuccess {
               // print("Got the movie's data")
                
                let moviesJSON : JSON = JSON(response.result.value!)
                
                if let da = moviesJSON["results"].arrayObject{
                    self.movieData = da as! [[String : AnyObject]]
                }
                if self.movieData.count > 0 {
                    self.collectionView?.reloadData()
                }
                
            }
            else {
                print ("Error\(String(describing: response.result.error))")
                
            }
        }
    }
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DataCollectionViewCell
        
        let iP = movieData [indexPath.row]
        cell?.label.text = iP["title"] as? String
        //let imageUrl = "https://image.tmdb.org/t/p/w200" + (iP["poster_path"] as! String)
        
        //get images
       
        if let imageUrl = iP["poster_path"] as? String {
            
            Alamofire.request("https://image.tmdb.org/t/p/w200" + imageUrl).responseImage(completionHandler: {
                (response) in
                if let image = response.result.value {
                    let size = CGSize(width: 140, height: 200)
                    let scaledImage = image.af_imageScaled(to:  size).af_imageRounded(withCornerRadius: 3.0)
                    
                    DispatchQueue.main.async {
                        cell?.img.image = scaledImage
                        
                    }
                }
                }
            )
        }
        
        return cell!
    }
    
    
    
    //perform segue and send data to video section


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        
        secondVC?.movieTitle = movieData[indexPath.row]["title"] as! String
        secondVC?.movieOverviewText = movieData[indexPath.row]["overview"] as! String
        //>>>>>   secondVC?.movieRatings = "\(movieData[indexPath.row]["vote_average"] as! Int)"
        
        
        //send poster
        /*let fotoUrl = movieData[indexPath.row]["poster_path"] as? String
        Alamofire.request("https://image.tmdb.org/t/p/w200" + fotoUrl!, method: .get).responseImage {
            response in
            guard let image = response.result.value else {
                return
            }
            secondVC?.posterImage = image
            } */
       
        print( "https://image.tmdb.org/t/p/w200" + (movieData[indexPath.row]["poster_path"] as! String))
        
        
        
        self.navigationController?.pushViewController(secondVC!, animated: true)
            
    }
    
    //prepare segue search
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendDataSearch" {
            
            let searchVC = segue.destination as! SearchViewController
            
            searchVC.delegate = self
        }
    }
    
    
    
    
    //////send seach back
    func dataReceived(data: String) {
        
        let movieSearch = data
        print(movieSearch)
        let movieSearchNoSpace = movieSearch.replacingOccurrences(of: " ", with: "%20")
        getMovieData(url: "https://api.themoviedb.org/3/search/movie?api_key=0abf1befdf259f8b383017249ba19a9a&language=en-US&query=\(movieSearchNoSpace)&page=1&include_adult=false&fbclid=IwAR1IStRWgwiRpnbkIbOl7KfqZTamu3slssZ1ezDgJAYY1VDDWkisweeYsBE")
        self.navigationController?.popViewController(animated: true)
    }
    
    //Logout Button
    @IBAction func logout(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
  

}




