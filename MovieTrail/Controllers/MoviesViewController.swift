//
//  ViewController.swift
//  MovieTrail
//
//  Created by Helder Pinto on 29/03/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit
import AlamofireImage


class MoviesViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource  {
    
    //Variables
    let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=0abf1befdf259f8b383017249ba19a9a&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")!
   
    var movies = [Movies]()
    
    //IBoutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //getMovieData(url: MOVIE_URL)
        fetchData(url: url)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (collectionView.frame.size.width - 20)/3, height: (collectionView.frame.size.height)/4)
        
    }
    
    //MARK: Networking
    func fetchData(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                
            } else {
                if let data = data {
                    do{
                        let fetchedMovies = try JSONDecoder().decode(Results.self, from: data)
                        self.movies = fetchedMovies.results
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }catch {
                        print("something went wrong")
                    }
                }
            }
        }
        task.resume()
    }

    //MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DataCollectionViewCell
        let movie = movies[indexPath.row]
        cell?.label.text = movie.title
        
        //get images from url
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w200" + movie.poster_path!)
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: imageUrl!)
                let image = UIImage(data: data)
                let size = CGSize(width: 140, height: 200)
                let scaledImage = image?.af_imageScaled(to:  size).af_imageRounded(withCornerRadius: 4.0)
                DispatchQueue.main.async {
                    cell?.img.image = scaledImage
                }
            }catch {
                print("error getting image")
            }
        }
       
        return cell!
    }
    
    
    //perform segue and send data to video section


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        let iP = movies[indexPath.row]
        secondVC?.movieTitle = iP.title!
        secondVC?.movieOverviewText = iP.overview!
        
        secondVC?.movieFotoUrl = "https://image.tmdb.org/t/p/w200" + (iP.poster_path!)
    
        self.navigationController?.pushViewController(secondVC!, animated: true)
            
    }
    

    
    // Add Unwind here
    @IBAction func unwindLocationCancel(segue:UIStoryboardSegue) {}
}

    
    
//    func dataReceived(data: String) {
//
//        let movieSearch = data
//
//        let movieSearchNoSpace = movieSearch.replacingOccurrences(of: " ", with: "%20")
//       // getMovieData(url: "https://api.themoviedb.org/3/search/movie?api_key=0abf1befdf259f8b383017249ba19a9a&language=en-US&query=\(movieSearchNoSpace)&page=1&include_adult=false&fbclid=IwAR1IStRWgwiRpnbkIbOl7KfqZTamu3slssZ1ezDgJAYY1VDDWkisweeYsBE")
//        self.navigationController?.popViewController(animated: true)
//    }
    

  





