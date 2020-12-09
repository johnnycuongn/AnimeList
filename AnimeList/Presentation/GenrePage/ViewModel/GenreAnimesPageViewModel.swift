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
    var animes: Observable<[GenreAnimeMain.GenreAnime]> { get }
    
    var loading: Observable<LoadingStyle?> { get }
    
    func loadAnimes(page: Int)
}

class DefaultGenreAnimesPageViewModel: GenreAnimesPageViewModel {
    var id: Int
    var animes: Observable<[GenreAnimeMain.GenreAnime]> = Observable([])

    var loading: Observable<LoadingStyle?> = Observable(.none)
    
    
    private let useCase: GenreAnimesUseCase
    
    init(id: Int,
         animeUseCase: GenreAnimesUseCase = DefaultGenreAnimesUseCase()) {
        self.id = id
        self.useCase = animeUseCase
    }
    
    func loadAnimes(page: Int = 1) {
        loading.value = .fullscreen
        
        useCase.getAnimes(id: self.id, page: page) { [weak self] (result) in
            switch result {
            case .success(let genreMain):
                self?.animes.value.append(contentsOf: genreMain.animes)
            case .failure(let error):
                print("Error: \(error)")
            }

            self?.loading.value = .none
        }
        
        
    }
}
