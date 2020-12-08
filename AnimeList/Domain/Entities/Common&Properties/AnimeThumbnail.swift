//
//  AnimeThumbnial.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol AnimeThumbnail {
    var malID: Int { get set }
    var imageURL: URL? { get set }
    var title: String { get set }
    var type: AnimeType? { get set }
    var episodes: Int? { get set }
    var members: Int? { get set }
    var score: Double? { get set }
}

protocol TopAnimeThumbnail: AnimeThumbnail {
    var rank: Int { get set }
}
