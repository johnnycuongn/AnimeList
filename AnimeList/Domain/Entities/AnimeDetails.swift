//
//  AnimeDetails.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

struct AnimeDetails {
    var malID: Int
    var url: String?
    var imageURL: URL?
    var trailerURL: URL?
    
    var title: String
    var titleEnglish: String?
    var synopsis: String?
    
    var type: AnimeType?
    var episodes: Int?
    
    var score: Double?
    var scoredBy: Int?
    
    var members: Int?
    var rank: Int?
    var popularity: Int?
    var favorites: Int?
    
    var premieredDate: String?
    var rating: String?
    var status: String?
    
    var studios: [String]
    var genres: [GenreDisplayDTO]
}
