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
    
    private func topRecommend() -> Int {
        // AnimeTopSubtype.bydefault
        // AnimeTopSubtype.bypopularity
        // AnimeTopSubtype.favorite
        var page = Int.random(in: 1...100)
        
        return 1
    }
    
    func recommendID(_ completion: @escaping (Int) -> Void) {
        
        var id: Int!
        
        var page = Int.random(in: 1...15)
        TopAnimeService.shared.fetchTopAnime(page: page, subtype: .bydefault) { (topAnimes) in
            id = topAnimes[Int.random(in: 0..<50)].malID
            completion(id)
        }
        
    }
    
}
