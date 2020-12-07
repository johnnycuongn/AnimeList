//
//  SearchAnimesUseCase.swift
//  AnimeList
//
//  Created by Johnny on 7/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol SearchAnimesUseCase {
    func getAnimes(page: Int, query: String, completion: @escaping (Result<SearchAnimeMain, Error>) -> Void)
}
