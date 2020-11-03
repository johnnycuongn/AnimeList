//
//  RecommendService.swift
//  AnimeList
//
//  Created by Johnny on 3/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class RecommendService {
    private init() {}
    static let shared = RecommendService()
    
    func recommendID(_ completion: @escaping (Int) -> Void) {
        
        var id: Int!
 
        TopAnimeService.shared.fetchTopAnime(page: 1, subtype: .bypopularity) { (topAnimes) in
            id = topAnimes[Int.random(in: 0..<50)].malID
            completion(id)
        }
        
    }
    
}
