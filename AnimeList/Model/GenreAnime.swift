//
//  GenreAnime.swift
//  AnimeList
//
//  Created by Johnny on 23/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class GenreAnimeMain: Decodable {
    var anime: [AnimeDisplayInfo]
    
    enum CodingKeys: String, CodingKey { case anime }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.anime = try container.decode([AnimeDisplayInfo].self, forKey: .anime)
    }
}
