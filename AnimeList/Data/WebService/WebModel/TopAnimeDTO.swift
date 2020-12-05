//
//  TopAnimeInfo.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class TopAnimesResponseDTO: Decodable {
    var top: [TopAnimeDTO]
    
    enum CodingKeys: String, CodingKey { case top }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        top = try container.decode([TopAnimeDTO].self, forKey: .top)
    }
}



class TopAnimeDTO: AnimeThumbnailDTO {
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

extension TopAnimeDTO {
    func toDomain() -> TopAnimeMain.TopAnime {
        return .init(rank: rank, malID: malID, imagePath: imageURL.absoluteString, title: title, type: type, episodes: episodes, members: members, score: score)
    }
}
