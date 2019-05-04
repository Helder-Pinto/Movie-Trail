//
//  SecondViewController.swift
//  MovieTrail
//
//  Created by Apple on 29/03/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreData
import YouTubePlayer

class VideoViewController: UIViewController {
    
    
    //Outlets
   
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var movieTitleField: UILabel!
    @IBOutlet weak var moviePosterField: UIImageView!
    
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieAverage: UILabel!
    
    //var myMoviesArray2 = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var imgData: Data?
    var movieId: Int!
    var movieTitle: String = ""
    var posterImage: UIImage!
    var movieOverviewText: String = ""
    var movieFotoUrl: String = ""
    var videos = [YouVid]() 
    
    //var movieRatings: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo()
        movieTitleField.text = movieTitle
        movieOverview.text = movieOverviewText
        miniPoster()
       
       
        }


    //Networking
    
    func getVideo(){
        let strId = String(movieId)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(strId)/videos?api_key=0abf1befdf259f8b383017249ba19a9a&language=en-US")!
     print(url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
            } else {
                if let data = data {
                    do{
                        let youtubeID = try JSONDecoder().decode(Vresponse.self, from: data)
                        self.videos = youtubeID.results
                        print(self.videos[0].key)
                        let vidUrl = URL(string: "https://www.youtube.com/watch?v=" + self.videos[0].key)!
                        
                        
                       DispatchQueue.main.async {
                        self.videoPlayer.loadVideoURL(vidUrl)
                       }
                    }catch {
                        print("something went wrong")
                    }
                }
            }
        }
        task.resume()
    }

    //Movie-Image
    func miniPoster (){
        DispatchQueue.global().async {
            do{
            let data = try Data(contentsOf: URL(string: self.movieFotoUrl)!)
            let image = UIImage(data: data)
            let size = CGSize(width: 140, height: 200)
            let scaledImage = image?.af_imageScaled(to:  size).af_imageRounded(withCornerRadius: 4.0)
            self.imgData = scaledImage?.jpegData(compressionQuality: 1)
                DispatchQueue.main.async {
                    self.moviePosterField.image = scaledImage
            }
                }catch {
            print("error getting image")
            }
    }
    
      }
    //MARK: add movie to mylist
    
    @IBAction func addFavsButton(_ sender: Any) {
        
        let newItem = Item(context: self.context)
        
        newItem.title = movieTitle
        newItem.watched = false
        newItem.image = imgData
        print(imgData)
            do{
                try context.save()
            } catch{
                print("Erro saving context \(error)")
            }
          let alert = UIAlertController(title: "✅", message: "Movie Added To List", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }

}
