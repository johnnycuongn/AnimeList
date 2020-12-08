//
//  GenreAnime.swift
//  AnimeList
//
//  Created by Johnny on 23/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class GenreAnimeDTO: AnimeThumbnailDTO {
}

class GenreAnimesResponseDTO: Decodable {
    var anime: [GenreAnimeDTO]
    var malURL: ShortDisplayDTO
    var itemCount: Int
    
    enum CodingKeys: String, CodingKey {
        case anime
        case malURL = "mal_url"
        case itemCount = "item_count"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.anime = try container.decode([GenreAnimeDTO].self, forKey: .anime)
        self.malURL = try container.decode(ShortDisplayDTO.self, forKey: .malURL)
        self.itemCount = try container.decode(Int.self, forKey: .itemCount)
    }
}
