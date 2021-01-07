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
    
    private let animeRepo: AnimeDetailsRepository
    
    init(animeRepository: AnimeDetailsRepository = DefaultAnimeFetchRepository()) {
        self.animeRepo = animeRepository
    }
    
    func getAnime(id: Int, completion: @escaping (Result<AnimeDetails, Error>) -> Void) {
        
        animeRepo.fetchAnimeDetails(id: id) { (result) in
            switch result {
            case .success(let animeDetails):
                completion(.success(animeDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
