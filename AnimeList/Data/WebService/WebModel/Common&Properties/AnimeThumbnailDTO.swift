//
//  AnimeThumbnailDTO.swift
//  AnimeList
//
//  Created by Johnny on 4/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class AnimeThumbnailDTO: Decodable {
    var malID: Int
    var imageURL: URL?
    var title: String
    var type: AnimeTypeDTO?
    var episodes: Int?
    var members: Int?
    var score: Double?
    
    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case title
        case imageURL = "image_url"
        case type
        case episodes
        case members
        case score
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        malID = try container.decode(Int.self, forKey: .malID)
        title = try container.decode(String.self, forKey: .title)
        imageURL = try? container.decode(URL.self, forKey: .imageURL)
        type = try? container.decode(AnimeTypeDTO.self, forKey: .type)
        episodes = try? container.decode(Int.self, forKey: .episodes)
        members = try? container.decode(Int.self, forKey: .members)
        score = try? container.decode(Double.self, forKey: .score)
    }
}
