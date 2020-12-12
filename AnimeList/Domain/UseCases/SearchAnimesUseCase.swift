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
    
    private let animeWS: SearchAnimeRepository
    
    init(animeWebService: SearchAnimeRepository = DefaultAnimeWebService()) {
        self.animeWS = animeWebService
    }
    
    func getAnimes(page: Int, searchText: String, completion: @escaping (Result<SearchAnimeMain, Error>) -> Void) {
        
        animeWS.fetchSearch(page: page, query: searchText) { (result) in
            switch result {
            case .success(let reponseDTO):
                completion(.success(reponseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
