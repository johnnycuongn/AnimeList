//
//  AnimeDisplayViewModel.swift
//  AnimeList
//
//  Created by Johnny on 28/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol AnimeDisplayViewModel {
    
    var id: Int { get }
    
    var imageURL: URL { get }
    var title: String { get }
    var score: String { get }
    var members: String { get }
    var type: String { get }
    var episode: String { get }
}
