//
//  +MappingDTOtoDomainEntities.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

// MARK: TopAnimeDTO
extension TopAnimeDTO {
    func toDomain() -> TopAnimeMain.TopAnime {
        
        let domainType = type?.toDomain()
        
        return .init(rank: rank, malID: malID, imagePath: imageURL.absoluteString, title: title, type: domainType, episodes: episodes, members: members, score: score)
    }
}

// MARK: SearchAnimeDTO
extension AnimeThumbnailDTO {
    func toDomain() -> AnimeThumbnail {
        
        let domainType = type?.toDomain()
        
        return .init(malID: malID, imagePath: imageURL.absoluteString, title: title, type: domainType, episodes: episodes, members: members, score: score)
    }
}

extension AnimeDetailsDTO {
    func toDomain() -> AnimeDetails {
        
        let domainType = type?.toDomain()
        
        return .init(malID: malID, url: url, imagePath: imageURL?.absoluteString, trailerURLPath: trailerURL, title: title, titleEnglish: titleEnglish, synopsis: synopsis, type: domainType, episodes: episodes, score: score, scoredBy: scoredBy, members: members, rank: rank, popularity: popularity, favorites: favorites, premieredDate: premieredDate, rating: rating, status: status)
    }
}
