//
//  PersonalAnime+CoreDataProperties.swift
//  AnimeList
//
//  Created by Johnny on 6/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonalAnime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonalAnime> {
        return NSFetchRequest<PersonalAnime>(entityName: "PersonalAnime")
    }

    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var dateSaved: Date?
    @NSManaged public var id: Int64

}

extension PersonalAnime : Identifiable {

}
