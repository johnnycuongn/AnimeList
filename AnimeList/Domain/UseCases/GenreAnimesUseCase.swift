//
//  GenreAnimesUseCase.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol GenreAnimesUseCase {
    func getAnimes(id: Int, page: Int, completion: @escaping (Result<GenreAnimeMain, Error>) -> Void )
}

class DefaultGenreAnimesUseCase: GenreAnimesUseCase {
    
    private let animeWS: GenreAnimeRepository
    
    init(animeWebService: GenreAnimeRepository = DefaultAnimeFetchRepository()) {
        self.animeWS = animeWebService
    }
    
    func getAnimes(id: Int, page: Int, completion: @escaping (Result<GenreAnimeMain, Error>) -> Void) {
        
        animeWS.fetchGenre(id: id, page: page) { (result) in
            switch result {
            case .success(let searchMain):
                completion(.success(searchMain))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
