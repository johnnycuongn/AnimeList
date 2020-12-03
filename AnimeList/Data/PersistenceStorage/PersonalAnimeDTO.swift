//
//  PersonalAnimeDTO.swift
//  AnimeList
//
//  Created by Johnny on 3/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import CoreData

struct PersonalAnimeDTO {
    
    var id: Int
    var title: String?
    
    var imageData: Data?
    var dateSaved: Date?
    
    
    func toEntity(in context: NSManagedObjectContext) -> PersonalAnimeEntity {
        let entity: PersonalAnimeEntity = .init(context: context)
        entity.id = Int64(id)
        entity.title = title
        
        entity.image = imageData
        entity.dateSaved = dateSaved
        
        return entity
    }
}
