//
//  TopAnimeInfo.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

struct TopAnimeMain: Decodable {
    var top: [TopAnimeInfo]
    
    enum CodingKeys: String, CodingKey { case top }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        top = try container.decode([TopAnimeInfo].self, forKey: .top)
    }
}

struct TopAnimeInfo: Decodable {
    var malID: Int
    var rank: Int
    var imageURL: URL
    var title: String
    var type: AnimeType
    var episodes: Int?
    var members: Int
    var score: Double
    
    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case rank
        case title
        case imageURL = "image_url"
        case type
        case episodes
        case members
        case score
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        malID = try container.decode(Int.self, forKey: .malID)
        rank = try container.decode(Int.self, forKey: .rank)
        title = try container.decode(String.self, forKey: .title)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        type = try container.decode(AnimeType.self, forKey: .type)
        episodes = try? container.decode(Int.self, forKey: .episodes)
        members = try container.decode(Int.self, forKey: .members)
        score = try container.decode(Double.self, forKey: .score)
    }
}
