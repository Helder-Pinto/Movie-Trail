//
//  GenreViewController.swift
//  MovieTrail
//
//  Created by Apple on 02/05/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let genreUrl = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=0abf1befdf259f8b383017249ba19a9a&language=en-US")!
    
    var genres = [Genre]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(url: genreUrl)

    }
    
    //MARK: Networking
    func fetchData(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                
            } else {
                if let data = data {
                    do{
                        let fetchedGenres = try JSONDecoder().decode(Categories.self, from: data)
                        self.genres = fetchedGenres.genres
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }catch {
                        print("something went wrong")
                    }
                }
            }
        }
        task.resume()
    }
    
    //MARK: Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)
        let genre = genres[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
        
    }
    

}

