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
    
    private let animeWS: TopAnimeWebService
    
    init(animeWebService: TopAnimeWebService = DefaultAnimeWebService()) {
        self.animeWS = animeWebService
    }
    
    func getAnimes(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeMain.TopAnime], Error>) -> Void) {
        
        animeWS.fetchTop(page: page, subtype: subtype) { (result) in
            switch result {
            case .success(let topAnimesDTO):
                completion(
                    .success(
                        topAnimesDTO.map { $0.toDomain() }
                        )
                )
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
}
