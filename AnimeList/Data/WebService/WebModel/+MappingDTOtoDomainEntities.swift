//
//  +MappingDTOtoDomainEntities.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation


// MARK: AnimeTypeDTO
extension AnimeTypeDTO {
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



// MARK: TopAnimeDTO
extension TopAnimeDTO {
    func toDomain() -> TopAnimeMain.TopAnime {
        
        let domainType = type?.toDomain()
        
        return .init(rank: rank, malID: malID, imageURL: imageURL, title: title, type: domainType, episodes: episodes, members: members, score: score)
    }
}



// MARK: AnimeThumbnailDTO
extension AnimeThumbnailDTO {
    func toDomain() -> AnimeThumbnail {
        
        let domainType = type?.toDomain()
        
        return .init(malID: malID, imageURL: imageURL, title: title, type: domainType, episodes: episodes, members: members, score: score)
    }
}



// MARK: AnimeDetailsDTO
extension AnimeDetailsDTO {
    func toDomain() -> AnimeDetails {
        
        let domainType = type?.toDomain()
        
        return .init(malID: malID, url: url, imageURL: imageURL, trailerURL: trailerURL, title: title, titleEnglish: titleEnglish, synopsis: synopsis, type: domainType, episodes: episodes, score: score, scoredBy: scoredBy, members: members, rank: rank, popularity: popularity, favorites: favorites, premieredDate: premieredDate, rating: rating, status: status)
    }
}


