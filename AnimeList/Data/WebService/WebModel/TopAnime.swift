//
//  TopAnimeInfo.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class TopAnimeMain: Decodable {
    var top: [TopAnime]
    
    enum CodingKeys: String, CodingKey { case top }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        top = try container.decode([TopAnime].self, forKey: .top)
    }
}



class TopAnime: AnimeDisplayInfo {
    var rank: Int
    
    enum TopCodingKeys: String, CodingKey {
        case rank
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: TopCodingKeys.self)
        self.rank = try container.decode(Int.self, forKey: .rank)
        
        try super.init(from: decoder)
        
    }
}
