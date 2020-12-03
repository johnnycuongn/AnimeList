//
//  PersonalAnimeCoreDataStorage.swift
//  AnimeList
//
//  Created by Johnny on 3/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import CoreData

protocol PersonalAnimeStorageCreateDelete {
    func add(id: Int, imageData: Data?, title: String?, date: Date)
    
    func remove(id: Int, completion: @escaping () -> Void)
    
    func isIDExist(_ id: Int, completion: @escaping (Bool) -> Void)
}

protocol PersonalAnimeStorageRead {
    func getAnimes(_ completion: @escaping (Result<[PersonalAnimeDTO], Error>) -> Void)
}

protocol PersonalAnimeStorage: PersonalAnimeStorageCreateDelete, PersonalAnimeStorageRead  {
}


class PersonalAnimeCoreDataStorage: PersonalAnimeStorage {
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    func getAnimes(_ completion: @escaping (Result<[PersonalAnimeDTO], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { (context) in
            do {
                let fetchRequest = self.fetchRequest()
                let animeEntities = try context.fetch(fetchRequest)
                
                completion(
                    .success(animeEntities.map {
                        $0.toDTO()
                    })
                )
                
            }
            catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func add(id: Int, imageData: Data?, title: String?, date: Date) {
        let addedAnime = PersonalAnimeEntity(context: coreDataStorage.context)
        
        addedAnime.id = Int64(id)
        addedAnime.image = imageData
        addedAnime.title = title
        addedAnime.dateSaved = date
        
        coreDataStorage.saveContext()
        print("\(String(describing: title)) saved!!!")
    }
    
    func remove(id: Int, completion: @escaping () -> Void) {
        let request = requestFor(id: id)
        
        
        do {
            let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: request) {
                (asyncFetchResult) in
                
                guard let idArray = asyncFetchResult.finalResult else { return }
                
                for id in idArray {
                    self.coreDataStorage.context.delete(id)
                }
                
                self.coreDataStorage.saveContext()
                completion()
            }
            
            try coreDataStorage.context.execute(asyncFetchRequest)
            
        }
        catch let error {
            print("Data Manager Error: \(error)")
        }
            
        
        
    }
    
    func isIDExist(_ id: Int, completion: @escaping (Bool) -> Void) {
        let request = requestFor(id: id)
        
        do {
            let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: request) {
                (asyncFetchResult) in
                
                guard let idArray = asyncFetchResult.finalResult else { return }
                
                
                if idArray.isEmpty {
                    completion(false)
                }
                else { completion(true) }
                
            }
            
            try coreDataStorage.context.execute(asyncFetchRequest)
            
        }
        catch let error {
            print("Data Manager Error: \(error)")
        }
        
    }
    
    
    // MARK: HELPERS
    private func fetchRequest() -> NSFetchRequest<PersonalAnimeEntity> {
        let request = PersonalAnimeEntity.fetchRequest() as NSFetchRequest<PersonalAnimeEntity>
        
        request.sortDescriptors = [NSSortDescriptor(key: "dateSaved", ascending: true)]
        
        return request
    }
    
    private func requestFor(id: Int) -> NSFetchRequest<PersonalAnimeEntity> {
        let request = PersonalAnimeEntity.fetchRequest() as NSFetchRequest<PersonalAnimeEntity>
        let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
        
        return request
    }

    
    
}
