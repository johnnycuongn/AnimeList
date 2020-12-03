//
//  PersonalAnimeEntity+CoreDataProperties.swift
//  AnimeList
//
//  Created by Johnny on 3/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonalAnimeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonalAnimeEntity> {
        return NSFetchRequest<PersonalAnimeEntity>(entityName: "PersonalAnimeEntity")
    }

    @NSManaged public var dateSaved: Date?
    @NSManaged public var id: Int64
    @NSManaged public var image: Data?
    @NSManaged public var title: String?

}

extension PersonalAnimeEntity : Identifiable {

}
