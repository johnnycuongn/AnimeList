//
//  GenreAnimesUseCase.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol GenreAnimesUseCase {
    func getAnimes(id: Int, page: Int, completion: @escaping (Result<GenreAnimeMain, Error>) -> Void )
}
