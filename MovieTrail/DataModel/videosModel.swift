//
//  videosModel.swift
//  MovieTrail
//
//  Created by Apple on 04/05/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import Foundation


struct Vresponse: Codable {
    let id: Int
    let results: [YouVid]
}

struct YouVid: Codable {
    let id: String
    let iso_639_1: String
    let iso_3166_1: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}
