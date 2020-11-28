//
//  JikanAPI.swift
//  AnimeList
//
//  Created by Johnny on 2/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol APIPath {
    func top(at page: Int, subtype: AnimeTopSubtype) -> URL
    func anime(id: Int) -> URL
    func search(page: Int, text: String) -> URL
    func genre(id: Int, page: Int) -> URL
}

// MARK: TopSubtype
enum AnimeTopSubtype: String {
    case bydefault = "Rating"
    case bypopularity = "Popularity"
    case favorite = "Favorite"
    case airing = "Airing"
    case upcoming = "Upcoming"
    case tv = "TV"
    case movie = "Movie"
    case ova = "OVA"
    case special = "Special"
}

// MARK: Search
enum SearchParameter: String {
    case q
    case page
    case type
    case genre
    case orderBy = "order_by"
    case members
    case letter
}

class JikanAnimeAPI {

    private let path: String = "https://api.jikan.moe/v3"
    
    private var anime: URL { return
        URL(string: path + "/anime")! }
    
    private var top: URL {
        return URL(string: path + "/top/anime")! }
    
    private var search: URL {
        return URL(string: path + "/search/anime")! }
    
    private var genre: URL {
        return URL(string: path + "/genre/anime")! }
}

extension JikanAnimeAPI: APIPath {
    func top(at page: Int = 1, subtype: AnimeTopSubtype) -> URL {
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
    
    func anime(id: Int) -> URL {
        let fetchURL = anime.appendingPathComponent(String(id))
        
        return fetchURL
    }
    
    func search(page: Int, text: String) -> URL {
        let query: [SearchParameter: String]
        
        guard text.count != 0 else { return search }
        
        if text.count == 1 {
            query = [
                .page: String(page),
                .letter: text,
                .orderBy: "members"
            ]
        }
        else {
            query = [
                .q : text,
                .page: String(page)
                
            ]
        }
        
        let fetchURL = search.searchWithQueries(query)!
        
        return fetchURL
    }
    
    func genre(id: Int, page: Int = 1) -> URL {
        return genre
            .appendingPathComponent(String(id))
            .appendingPathComponent(String(page))
    }
    
}
