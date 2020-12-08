//
//  GenreAnime.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

struct GenreAnimeMain {
    
    struct GenreAnime: AnimeThumbnail {
        var malID: Int
        var imageURL: URL?
        var title: String
        var type: AnimeType?
        var episodes: Int?
        var members: Int?
        var score: Double?
    }
    
    var name: String
    
    var animes: [GenreAnime]
    var animesCount: Int
}
