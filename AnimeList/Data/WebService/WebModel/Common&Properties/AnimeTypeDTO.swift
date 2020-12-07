//
//  AnimeTypeDTO.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
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
