//
//  GenreAnimesPageViewModel.swift
//  AnimeList
//
//  Created by Johnny on 2/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol GenreAnimesPageViewModel {
    var id: Int { get }
    var animes: Observable<[AnimeThumbnailDTO]> { get }
    
    var loading: Observable<LoadingStyle?> { get }
    
    func loadAnimes(page: Int)
}

class DefaultGenreAnimesPageViewModel: GenreAnimesPageViewModel {
    var id: Int
    var animes: Observable<[AnimeThumbnailDTO]> = Observable([])

    var loading: Observable<LoadingStyle?> = Observable(.none)
    
    private var animeWS: GenreAnimeWebService
    
    init(id: Int, animeWebService: GenreAnimeWebService = DefaultAnimeWebService()) {
        self.id = id
        self.animeWS = animeWebService
    }
    
    func loadAnimes(page: Int = 1) {
        loading.value = .fullscreen
        animeWS.fetchGenre(id: self.id, page: page) { [weak self] (result) in
            switch result {
            case .success(let genreMain):
                self?.animes.value.append(contentsOf: genreMain.anime)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        loading.value = .none
    }
}
