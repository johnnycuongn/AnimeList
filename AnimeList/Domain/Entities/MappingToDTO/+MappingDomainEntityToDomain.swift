//
//  +MappingDomainEntityToDomain.swift
//  AnimeList
//
//  Created by Johnny on 9/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

extension AnimeTopSubtype {
    func toDTO() -> AnimeTopSubtypeRequest {
        switch self {
        case .bydefault:
            return .bydefault
        case .bypopularity:
            return .bypopularity
        case .favorite:
            return .favorite
        case .airing:
            return .airing
        case .upcoming:
            return .upcoming
        case .tv:
            return .tv
        case .movie:
            return .movie
        case .ova:
            return .ova
        case .special:
            return .special
        }
    }
}
