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
    func search(_ types: SearchType...) -> URL
}

enum SearchType {
    case query(String)
    case page(Int)
    case type(AnimeTopSubtypeRequest)
    case status(AnimeStatus)
    case rated(AnimeRated)
    case genres([Genre])
    case orderBy(AnimeSearchOrderBy)
    case score(Float)
    case genreExclude(Bool)
    case limit(Int)
    case sort(AnimeSearchSort)
    case letter(String)
}

// MARK: TopSubtypeRequest
enum AnimeTopSubtypeRequest: String {
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

enum AnimeSearchOrderBy: String {
    case title
    case startDate = "start_date"
    case endDate = "end_date"
    case score
    case type
    case members
    case id
    case episodes
    case rating
}

enum AnimeSearchSort: String {
    case asc, desc
}

enum AnimeRated: String {
    case g
    case pg
    case pg13
    case r17
    case r
    case rx
}

enum AnimeStatus: String {
    case airing
    case complete
    case toBeAired = "to_be_aired"
    case tba
    case upcoming
}

// MARK: SearchParameter
enum SearchParameter: String {
    case q
    case page
    case type //AnimeTopSubtypeRequest
    case status
    case rated
    case genre
    case orderBy = "order_by"
    case score
    case genreExclude = "genre_exclude"
    case limit
    case sort
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
    
    func search(_ types: SearchType...) -> URL {
        var endQuery: [SearchParameter: String] = [:]
        
        for type in types {
            func addQuery(_ value: [SearchParameter: String]) {
                endQuery.merge(value) { current, new in
                    new
                }
            }
            
            switch type {
            case .query(let query):
                if query.count < 3 {
                    addQuery([
                        .letter: query,
                        .orderBy: "members"
                    ])
                }
                else {
                    addQuery([.q : query])
                }
            case .type(let animeType):
                addQuery([.type: animeType.rawValue])
            case .status(let status): addQuery([.status: status.rawValue])
            case .rated(let rated): addQuery([.rated: rated.rawValue])
            case .genres(let genres):
                let genresValue = genres.map({"\($0.rawValue)"}).joined(separator: ",")
                addQuery([.genre: genresValue])
            case .genreExclude(let genreExclude):
                addQuery([.genreExclude: genreExclude ? "0" : "1"])
            case .score(let score):
                addQuery([.score: String(score)])
            case .limit(let limit):
                addQuery([.limit: String(limit)])
            case .orderBy(let orderBy):
                addQuery([.orderBy: orderBy.rawValue])
            case .sort(let sort):
                addQuery([.sort: sort.rawValue])
            case .letter(let letter):
                addQuery([.letter: letter])
            case .page(let page):
                addQuery([.page: String(page)])
            }
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
