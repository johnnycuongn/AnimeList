//
//  AnimeService.swift
//  AnimeList
//
//  Created by Johnny on 1/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol AnimeWebService {
    var networkManager: Networking { get set }
    var apiPath: APIPath { get set }
    
    func fetchAnimeDetails(id: Int, completion: @escaping (Result<AnimeDetailsDTO, Error>) -> Void)
    
    func fetchTop(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeDTO], Error>) -> Void)
    
    func fetchSearch(page: Int, query: String, completion: @escaping (Result<SearchAnimeMain, Error>) -> Void)
    
    func fetchGenre(id: Int, page: Int, completion: @escaping (Result<GenreAnimeMain, Error>) -> Void )
}

class DefaultAnimeWebService: AnimeWebService {
    
    var networkManager: Networking
    var apiPath: APIPath
    
    init(networkManager: Networking = NetworkManager(), apiPath: APIPath = JikanAnimeAPI()) {
        self.networkManager = networkManager
        self.apiPath = apiPath
    }
    
    // MARK: ANIME DETAILS
    func fetchAnimeDetails(id: Int, completion: @escaping (Result<AnimeDetailsDTO, Error>) -> Void) {
        let endpointURL = apiPath.anime(id: id)
        print("Fetch Anime URL - \(endpointURL)")
        
        networkManager.request(url: endpointURL) { (data) in
            guard let data = data else {
                print("AnimeInfoService: Unable to retrieve data")
                return
            }
            
            do {
                let anime = try JSONDecoder().decode(AnimeDetailsDTO.self, from: data)
            
                DispatchQueue.main.async {
                    completion(.success(anime))
                }
            }
            catch let error {
                print("Anime Fetch Error: \(error)")
                completion(.failure(error))
            }
        }
    }

    // MARK: TOP ANIMES
    func fetchTop(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeDTO], Error>) -> Void) {
        
        let endpointURL = apiPath.top(at: page, subtype: subtype)
        print("Top Fetch URL: \(endpointURL)")
        
        networkManager.request(url: endpointURL) { (data) in
            guard let data = data else {
                print("TopAnimeService: Unable to retrive data")
                return
            }
            
            do {
                let topAnimeMain = try JSONDecoder().decode(TopAnimeMain.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(topAnimeMain.top))
                }
            }
            catch let error {
                print("TopAnimeService: Fetch Error - \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: SEARCH ANIMES
    func fetchSearch(page: Int, query: String, completion: @escaping (Result<SearchAnimeMain, Error>) -> Void) {
        let endpointURL = apiPath.search(page: page, text: query)
        print("Search Fetch URL: \(endpointURL)")
        
        networkManager.request(url: endpointURL) { (data) in
            guard let data = data else {
                print("SearchAnimeService: Unable to retrive data")
                return
            }
            
            do {
                let searchMain = try JSONDecoder().decode(SearchAnimeMain.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(searchMain))
                }
            }
            catch let error {
                print("SearchAnimeService: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchGenre(id: Int, page: Int, completion: @escaping (Result<GenreAnimeMain, Error>) -> Void) {
        let endpointURL = apiPath.genre(id: id, page: page)
        print("Genre Fetch URL: \(endpointURL)")
        
        networkManager.request(url: endpointURL) { (data) in
            guard let data = data else {
                print("GenreAnimeServicve: Unable to retrive data")
                return
            }
            
            do {
                let genreAnimeMain = try JSONDecoder().decode(GenreAnimeMain.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(genreAnimeMain))
                }
            }
            catch let error {
                print("GenreAnimeService: Fetch error \(error)")
                completion(.failure(error))
            }
        }
    }
    
    
    
}