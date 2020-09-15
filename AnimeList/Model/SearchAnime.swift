//
//  SearchAnime.swift
//  AnimeList
//
//  Created by Johnny on 15/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation


class SearchAnimeMain: Decodable {
    var results: [SearchAnime]
    var lastPage: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case lastPage = "last_page"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.results = try container.decode([SearchAnime].self, forKey: .results)
        self.lastPage = try container.decode(Int.self, forKey: .lastPage)
    }
}

class SearchAnime: AnimeDisplayInfo {
    
}
