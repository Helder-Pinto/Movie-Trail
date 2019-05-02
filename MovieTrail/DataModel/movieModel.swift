//
//  moviesModel.swift
//  MovieTrail
//
//  Created by Apple on 02/05/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import Foundation

struct Results: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movies]
    
    
}

struct Movies: Codable{
    
    let vote_count: Int?
    let id: Int?
    let video: Bool?
    let vote_average: Float?
    let title: String?
    let popularity: Double?
    let poster_path: String?
    let original_language: String?
    let original_title: String?
    let genre_ids: [Int]?
    let backdrop_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
    
    
}
