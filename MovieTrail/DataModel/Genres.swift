//
//  Genres.swift
//  MovieTrail
//
//  Created by Apple on 02/05/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import Foundation


struct Categories: Codable{
    let genres: [Genre]
    
}

struct Genre: Codable {
    let id : Int
    let name : String
}

