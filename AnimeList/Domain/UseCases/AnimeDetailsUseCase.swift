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
    
    func loadSave(id: Int, completion: @escaping (Bool) -> Void)
    
    func updateSave(id: Int, updatedValue: @escaping (Bool) -> Void)
}

class DefaultAnimeDetailsUseCase: AnimeDetailsUseCase {
    
    private let animeWS: AnimeDetailsWebService
    private let animeStorage: PersonalAnimeStorageCreateDelete
    
    init(animeWebService: AnimeDetailsWebService = DefaultAnimeWebService(), animeStorage: PersonalAnimeStorageCreateDelete = PersonalAnimeCoreDataStorage()) {
        self.animeWS = animeWebService
        self.animeStorage = animeStorage
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
    
    func updateSave(id: Int, updatedValue: @escaping (Bool) -> Void) {
        
    }
    
    func loadSave(id: Int, completion: @escaping (Bool) -> Void) {
        animeStorage.isIDExist(id) { (isExisted) in
            completion(isExisted)
        }
    }
}
