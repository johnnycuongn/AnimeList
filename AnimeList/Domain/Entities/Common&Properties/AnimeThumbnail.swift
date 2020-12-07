//
//  AnimeThumbnial.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

struct AnimeThumbnail {
    var malID: Int
    var imageURL: URL?
    var title: String
    var type: AnimeType?
    var episodes: Int?
    var members: Int?
    var score: Double?
}
