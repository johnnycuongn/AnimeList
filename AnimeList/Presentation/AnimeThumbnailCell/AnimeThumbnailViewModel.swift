//
//  AnimeDisplayViewModel.swift
//  AnimeList
//
//  Created by Johnny on 28/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol AnimeThumbnailViewModel {
    
    var id: Int { get }
    
    var imageURL: URL { get }
    var title: String { get }
    var score: String { get }
    var members: String { get }
    var type: String { get }
    var episode: String { get }
}

class DefaultAnimeThumbnailViewModel: AnimeThumbnailViewModel {
    var id: Int
    
    var imageURL: URL
    var title: String
    
    var score: String
    var members: String
    
    var type: String
    var episode: String
    
    init(animeThumbnail: AnimeThumbnail) {
        self.id = animeThumbnail.malID
        
        if let urlPath = animeThumbnail.imageURL {
            self.imageURL = urlPath
        } else {
            self.imageURL = URL(string: "")!
        }
        
        self.title = animeThumbnail.title
        
        if animeThumbnail.score == 0 {
            self.score = "-" }
        else {
            self.score = validateLabel(animeThumbnail.score) }
        
        self.members = validateLabel(animeThumbnail.members)
        
        self.type = validateLabel(animeThumbnail.type?.rawValue, return: .none)
        
        self.episode = validateLabel(animeThumbnail.episodes)
    }
    
    
}
