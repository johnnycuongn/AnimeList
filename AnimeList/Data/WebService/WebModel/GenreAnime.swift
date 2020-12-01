//
//  GenreAnime.swift
//  AnimeList
//
//  Created by Johnny on 23/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class GenreAnimeMain: Decodable {
    var anime: [AnimeThumbnailDTO]
    var malURL: DisplayInfoDTO
    var itemCount: Int
    
    enum CodingKeys: String, CodingKey {
        case anime
        case malURL = "mal_url"
        case itemCount = "item_count"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.anime = try container.decode([AnimeThumbnailDTO].self, forKey: .anime)
        self.malURL = try container.decode(DisplayInfoDTO.self, forKey: .malURL)
        self.itemCount = try container.decode(Int.self, forKey: .itemCount)
    }
}
