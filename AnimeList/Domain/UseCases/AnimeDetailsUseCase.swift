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
    
    func addToStorage(id: Int, imageData: Data?, title: String, date: Date, completion: @escaping () -> Void)
    func removeFromStorage(id: Int, completion: @escaping () -> Void)
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
    
    func addToStorage(id: Int, imageData: Data?, title: String, date: Date, completion: @escaping () -> Void) {
        if imageData == nil  {
            animeStorage.add(id: id,
                             imageData: nil,
                             title: title,
                             date: date)
        }
        else {
            animeStorage.add(id: id,
                             imageData: imageData!,
                             title: title,
                             date: date)
        }
    }
    
    func removeFromStorage(id: Int, completion: @escaping () -> Void) {
        animeStorage.remove(id: id) {
            completion()
        }
    }
    
    func loadSave(id: Int, completion: @escaping (Bool) -> Void) {
        animeStorage.isIDExist(id) { (isExisted) in
            completion(isExisted)
        }
    }
}
