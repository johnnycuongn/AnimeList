//
//  JikanAPI.swift
//  AnimeList
//
//  Created by Johnny on 2/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

// MARK: <<APIPath>>
protocol APIPath {
    func top(at page: Int, subtype: AnimeTopSubtypeRequest) -> URL
    func anime(id: Int) -> URL
    func search(page: Int, query: String) -> URL
    func genre(id: Int, page: Int) -> URL
}

// MARK: TopSubtypeRequest
enum AnimeTopSubtypeRequest {
    case bydefault
    case bypopularity
    case favorite
    case airing
    case upcoming
    case tv
    case movie
    case ova
    case special
}

// MARK: SearchParameter
enum SearchParameter: String {
    case q
    case page
    case type
    case genre
    case orderBy = "order_by"
    case members
    case letter
}

// MARK: - JikanAPI
class JikanAnimeAPI {

    private let baseURL: String = "https://api.jikan.moe/v3"
    
    private var anime: URL { return
        URL(string: baseURL + "/anime")! }
    
    private var top: URL {
        return URL(string: baseURL + "/top/anime")! }
    
    private var search: URL {
        return URL(string: baseURL + "/search/anime")! }
    
    private var genre: URL {
        return URL(string: baseURL + "/genre/anime")! }
}

extension JikanAnimeAPI: APIPath {
    // MARK: TOP
    func top(at page: Int = 1, subtype: AnimeTopSubtypeRequest) -> URL {
        var fetchURL = top.appendingPathComponent(String(page))
        
        switch subtype {
        case .bydefault:
            // Do nothing
            print()
        case .bypopularity:
            fetchURL = fetchURL.appendingPathComponent("bypopularity")
        default:
            fetchURL = fetchURL.appendingPathComponent(String(describing: subtype))
        }
    
        return fetchURL
    }
    
    // MARK: ANIME
    func anime(id: Int) -> URL {
        let fetchURL = anime.appendingPathComponent(String(id))
        
        return fetchURL
    }
    
    // MARK: SEARCH
    func search(page: Int, query: String) -> URL {
        let endQuery: [SearchParameter: String]
        
        guard query.count != 0 else { return search }
        
        if query.count == 1 {
            endQuery = [
                .page: String(page),
                .letter: query,
                .orderBy: "members"
            ]
        }
        else {
            endQuery = [
                .q : query,
                .page: String(page)
                
            ]
        }
        
        let fetchURL = search.searchWithQueries(endQuery)!
        
        return fetchURL
    }
    
    // MARK: GENRE
    func genre(id: Int, page: Int = 1) -> URL {
        return genre
            .appendingPathComponent(String(id))
            .appendingPathComponent(String(page))
    }
    
}
