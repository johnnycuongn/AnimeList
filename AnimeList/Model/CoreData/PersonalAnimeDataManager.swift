//
//  PersonalAnimeDataManager.swift
//  AnimeList
//
//  Created by Johnny on 6/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersonalAnimeDataManager {
    
    static var animes: [PersonalAnime] {
        return fetchFromDB()
    }
    
    static func fetchFromDB() -> [PersonalAnime] {
        var tempList = [PersonalAnime]()
        
        do {
            let request = PersonalAnime.fetchRequest() as NSFetchRequest<PersonalAnime>
            
            request.sortDescriptors = [NSSortDescriptor(key: "dateSaved", ascending: true)]
            
            tempList = try PersistenceService.context.fetch(request)
        }
        catch let error {
            print("Unable to fetch from DB: \(error)")
        }
        
        return tempList
    }
    
    static func add(id: Int, image: UIImage?, title: String?, date: Date) {
        let addedAnime = PersonalAnime(context: PersistenceService.context)
        
        addedAnime.id = Int64(id)
        addedAnime.image = image?.pngData()
        addedAnime.title = title
        addedAnime.dateSaved = date
        
        PersistenceService.saveContext()
        print("\(title) saved!!!")
    }
    
    static func remove(at index: Int) {
        let removedAnime = self.animes[index]
        
        PersistenceService.context.delete(removedAnime)
        PersistenceService.saveContext()
    }
    
}
