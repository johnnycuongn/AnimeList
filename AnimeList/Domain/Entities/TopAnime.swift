//
//  TopAnime.swift
//  AnimeList
//
//  Created by Johnny on 4/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation


struct TopAnimeMain {
    
    struct TopAnime: TopAnimeThumbnail {
        var rank: Int
        
        var malID: Int
        var imageURL: URL?
        var title: String
        var type: AnimeType?
        var episodes: Int?
        var members: Int?
        var score: Double?
    }

    
    var animes: [TopAnime]
}
