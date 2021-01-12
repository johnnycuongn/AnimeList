//
//  Episode.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

struct EpisodeDTO: Decodable {
    var episodeID: Int
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        episodeID = try container.decode(Int.self, forKey: .episodeID)
        title = try container.decode(String.self, forKey: .title)
    }
}
