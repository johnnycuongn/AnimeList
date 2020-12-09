//
//  SavingAnimeUseCase.swift
//  AnimeList
//
//  Created by Johnny on 9/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol SavingAnimeUseCase {
    func loadSave(id: Int, completion: @escaping (Bool) -> Void)
    
    func addToStorage(id: Int, imageData: Data?, title: String, date: Date, completion: @escaping () -> Void)
    func removeFromStorage(id: Int, completion: @escaping () -> Void)
}

class DefaultSavingAnimeUseCase: SavingAnimeUseCase {
    private let animeStorage: PersonalAnimeStorageCreateDelete
    
    init(animeStorage: PersonalAnimeStorageCreateDelete) {
        self.animeStorage = animeStorage
    }
    
    func loadSave(id: Int, completion: @escaping (Bool) -> Void) {
        animeStorage.isIDExist(id) { (isExisted) in
            completion(isExisted)
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
        completion()
    }
    
    func removeFromStorage(id: Int, completion: @escaping () -> Void) {
        animeStorage.remove(id: id) {
            completion()
        }
    }
}
