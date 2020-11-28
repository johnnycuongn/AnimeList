//
//  ShortInfo.swift
//  AnimeList
//
//  Created by Johnny on 4/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class ShortInfo: Decodable {
    var malID: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.malID = try container.decode(Int.self, forKey: .malID)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
