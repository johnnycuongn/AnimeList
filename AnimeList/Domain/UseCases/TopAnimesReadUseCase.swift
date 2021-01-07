//
//  TopAnimesReadUseCase.swift
//  AnimeList
//
//  Created by Johnny on 5/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol TopAnimesReadUseCase {
    func getAnimes(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeMain.TopAnime], Error>) -> Void)
}

class DefaultTopAnimesReadUseCase: TopAnimesReadUseCase {
    
    private let animeRepo: TopAnimeRepository
    
    init(animeRepository: TopAnimeRepository = DefaultAnimeFetchRepository()) {
        self.animeRepo = animeRepository
    }
    
    func getAnimes(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeMain.TopAnime], Error>) -> Void) {
        
        animeRepo.fetchTop(page: page, subtype: subtype) { (result) in
            switch result {
            case .success(let topAnimes):
                completion(
                    .success(topAnimes)
                )
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
}
