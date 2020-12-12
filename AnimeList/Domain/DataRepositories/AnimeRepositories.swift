//
//  AnimeRepositories.swift
//  AnimeList
//
//  Created by Johnny on 12/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol AnimeDetailsRepository {
    func fetchAnimeDetails(id: Int, completion: @escaping (Result<AnimeDetails, Error>) -> Void)
}

protocol TopAnimeRepository {
    func fetchTop(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeMain.TopAnime], Error>) -> Void)
}

protocol SearchAnimeRepository {
    func fetchSearch(page: Int, query: String, completion: @escaping (Result<SearchAnimeMain, Error>) -> Void)
}

protocol GenreAnimeRepository {
    func fetchGenre(id: Int, page: Int, completion: @escaping (Result<GenreAnimeMain, Error>) -> Void )
}

protocol AnimeFetchRepository: AnimeDetailsRepository,
                          TopAnimeRepository,
                          SearchAnimeRepository,
                          GenreAnimeRepository {}
