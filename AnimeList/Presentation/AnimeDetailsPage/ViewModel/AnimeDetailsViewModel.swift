//
//  AnimeDetailsDisplayViewModel.swift
//  AnimeList
//
//  Created by Johnny on 29/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

// MARK: - VIEW MODEL

protocol AnimeDetailsViewModel {
    
    var posterImageData: Observable<Data?> { get set }
    
    var score: String { get set }
    var rank: String { get set }
    var popularity: String { get set }
    var members: String { get set }
    var favorites: String { get set }

    var studio: String { get set}

    var type: String { get set }
    var episodes: String { get set }

    var premiered: String { get set }
    var status: String { get set }

    var rating: String { get set }

    var title: String { get set }
    var engTitle: String { get set }

    var synopsis: String { get set }

    var genres: [GenreDisplayDTO] { get set }
}




// MARK: - DEFAULT VIEW MODEL


class DefaultAnimeDetailsViewModel: AnimeDetailsViewModel {
    
    var posterImageData: Observable<Data?> = Observable(nil)
    
    var score: String = ""
    var rank: String = ""
    var popularity: String = ""
    var members: String = ""
    var favorites: String = ""
    
    var studio: String = ""
    
    var type: String = ""
    var episodes: String = ""
    
    var premiered: String = ""
    var status: String = ""
     
    var rating: String = ""
    
    var title: String = ""
    var engTitle: String = ""
    
    var synopsis: String = ""
    var genres: [GenreDisplayDTO] = []

}
