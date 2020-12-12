//
//  AnimeDetailsUseCase.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol AnimeDetailsUseCase {
    func getAnime(id: Int, completion: @escaping (Result<AnimeDetails, Error>) -> Void)
}

class DefaultAnimeDetailsUseCase: AnimeDetailsUseCase {
    
    private let animeWS: AnimeDetailsRepository
    
    init(animeWebService: AnimeDetailsRepository = DefaultAnimeWebService()) {
        self.animeWS = animeWebService
    }
    
    func getAnime(id: Int, completion: @escaping (Result<AnimeDetails, Error>) -> Void) {
        
        animeWS.fetchAnimeDetails(id: id) { (result) in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
