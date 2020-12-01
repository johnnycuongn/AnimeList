//
//  TopAnimeDisplayViewModel.swift
//  AnimeList
//
//  Created by Johnny on 28/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol TopAnimeDisplayViewModel: AnimeDisplayViewModel {
    var rank: String { get }
    
    init(animeInfo: TopAnimeDTO)
}

struct DefaultTopAnimeDisplayViewModel: TopAnimeDisplayViewModel {
    
    var imageURL: URL
    
    var rank: String
    var title: String
    var score: String
    var members: String
    var type: String
    var episode: String
    
    init(animeInfo: TopAnimeDTO) {
        self.imageURL = animeInfo.imageURL
        
        self.rank = String(animeInfo.rank)
        
        self.title = animeInfo.title
        
        if animeInfo.score == 0 {
            self.score = "-" }
        else {
            self.score = validateLabel(animeInfo.score) }
        
        self.members = String(animeInfo.members)
        
        self.type = validateLabel(animeInfo.type?.rawValue, return: .none)
        
        self.episode = validateLabel(animeInfo.episodes)
    }
    
}

