//
//  SearchAnimesUseCase.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol SearchAnimesUseCase {
    func getAnimes(page: Int, searchText: String, completion: @escaping (Result<SearchAnimeMain, Error>) -> Void)
}

class DefaultSearchAnimesUseCase: SearchAnimesUseCase {
    
    private let animeRepo: SearchAnimeRepository
    
    init(animeRepository: SearchAnimeRepository = DefaultAnimeFetchRepository()) {
        self.animeRepo = animeRepository
    }
    
    func getAnimes(page: Int, searchText: String, completion: @escaping (Result<SearchAnimeMain, Error>) -> Void) {
        
        animeRepo.fetchSearch(page: page, query: searchText) { (result) in
            switch result {
            case .success(let searchMain):
                completion(.success(searchMain))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
