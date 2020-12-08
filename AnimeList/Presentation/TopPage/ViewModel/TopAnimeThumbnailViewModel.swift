//
//  TopAnimeDisplayViewModel.swift
//  AnimeList
//
//  Created by Johnny on 28/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol TopAnimeThumbnailViewModel: AnimeThumbnailViewModel {
    var rank: String { get }
}

class DefaultTopAnimeThumbnailViewModel: DefaultAnimeThumbnailViewModel, TopAnimeThumbnailViewModel {
    
    var rank: String
   
    init(animeThumbnail: TopAnimeThumbnail) {
        self.rank = String(animeThumbnail.rank)
        super.init(animeThumbnail: animeThumbnail)
    }
    
}

