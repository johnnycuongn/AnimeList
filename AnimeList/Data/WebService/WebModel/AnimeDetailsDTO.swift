//
//  AnimeInformation.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

enum AnimeTypeDTO: String, Codable {
    case tv = "TV"
    case movie = "Movie"
    case ova = "OVA"
    case special = "Special"
    case ona = "ONA"
    case music = "Music"
    
    func toDomain() -> AnimeType {
        switch self {
        case .tv: return .tv
        case .movie: return .movie
        case .ova: return .ova
        case .special: return .special
        case .ona: return .ona
        case .music: return .music
        }
    }
}

class AnimeDetailsDTO: Decodable {
    
    var malID: Int
    var url: String?
    var imageURL: URL?
    var trailerURL: String?
    var title: String
    var titleEnglish: String?
    var synopsis: String?
    var type: AnimeTypeDTO
    var episodes: Int?
    var score: Double?
    var scoredBy: Int?
    var members: Int?
    var rank: Int?
    var popularity: Int?
    var premieredDate: String?
    var favorites: Int?
    var rating: String?
    var status: String?
    
    var genres: [GenreDisplayDTO]
    var studios: [StudioDisplayDTO]
    
    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url
        case imageURL = "image_url"
        case trailerURL = "trailer_url"
        case title
        case titleEnglish = "title_english"
        case synopsis
        case type
        case episodes
        case score
        case scoredBy = "scored_by"
        case members
        case rank
        case popularity
        case premieredDate = "premiered"
        case favorites
        case rating
        case status
        
        case genres
        case studios
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        malID = try container.decode(Int.self, forKey: .malID)
        url = try? container.decode(String.self, forKey: .url)
        imageURL = try? container.decode(URL.self, forKey: .imageURL)
        trailerURL = try? container.decode(String.self, forKey: .trailerURL)
        title = try container.decode(String.self, forKey: .title)
        titleEnglish = try? container.decode(String.self, forKey: .titleEnglish)
        synopsis = try container.decode(String.self, forKey: .synopsis)
        type = try container.decode(AnimeTypeDTO.self, forKey: .type)
        episodes = try? container.decode(Int.self, forKey: .episodes)
        score = try? container.decode(Double.self, forKey: .score)
        scoredBy = try? container.decode(Int.self, forKey: .scoredBy)
        members = try? container.decode(Int.self, forKey: .members)
        rank = try? container.decode(Int.self, forKey: .rank)
        popularity = try? container.decode(Int.self, forKey: .popularity)
        premieredDate = try? container.decode(String.self, forKey: .premieredDate)
        favorites = try? container.decode(Int.self, forKey: .favorites)
        rating = try? container.decode(String.self, forKey: .rating)
        status = try? container.decode(String.self, forKey: .status)
        
        genres = try container.decode([GenreDisplayDTO].self, forKey: .genres)
        studios = try container.decode([StudioDisplayDTO].self, forKey: .studios)
    }
    
    
    
    
    
}
