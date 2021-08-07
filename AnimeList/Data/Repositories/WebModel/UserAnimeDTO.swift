//
//  UserAnimeDTO.swift
//  AnimeList
//
//  Created by Johnny on 7/8/21.
//  Copyright © 2021 Johnny. All rights reserved.
//

import Foundation

class UserAnimeResponse: Decodable {
    var anime: [UserAnimeDTO]
}

class UserAnimeDTO: Decodable {
    var malID: Int
    var imageURL: URL?
    var title: String
    var type: AnimeTypeDTO?
    var score: Double?
    
    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case title
        case imageURL = "image_url"
        case type
        case score
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        malID = try container.decode(Int.self, forKey: .malID)
        title = try container.decode(String.self, forKey: .title)
        imageURL = try? container.decode(URL.self, forKey: .imageURL)
        type = try? container.decode(AnimeTypeDTO.self, forKey: .type)
        score = try? container.decode(Double.self, forKey: .score)
    }
}
