//
//  AnimeService.swift
//  AnimeList
//
//  Created by Johnny on 1/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation



//MARK: - Default Implementation
class DefaultAnimeFetchRepository: AnimeFetchRepository {
    
    private var networkManager: Networking
    private var apiPath: APIPath
    
    init(networkManager: Networking = NetworkManager(), apiPath: APIPath = JikanAnimeAPI()) {
        self.networkManager = networkManager
        self.apiPath = apiPath
    }
    
    // MARK: ANIME DETAILS
    func fetchAnimeDetails(id: Int, completion: @escaping (Result<AnimeDetails, Error>) -> Void) {
        let endpointURL = apiPath.anime(id: id)
        print("Fetch Anime URL - \(endpointURL)")
        
        networkManager.request(url: endpointURL) { (data,error)  in
            guard let data = data else {
                print("AnimeInfoService: Unable to retrieve data")
                return
            }
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let anime = try JSONDecoder().decode(AnimeDetailsDTO.self, from: data)
            
                DispatchQueue.main.async {
                    completion(.success(anime.toDomain()))
                }
            }
            catch let error {
                print("Anime Fetch Error: \(error)")
                completion(.failure(error))
            }
        }
    }

    // MARK: TOP ANIMES
    var topItemsLoadPerPage: Int = 50
    
    func fetchTop(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeMain.TopAnime], Error>) -> Void) {
        
        let endpointURL = apiPath.top(at: page, subtype: subtype.toDTO())
        print("Top Fetch URL: \(endpointURL)")
        
        networkManager.request(url: endpointURL) { (data,error)  in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                print("TopAnimeService: Unable to retrive data")
                return
            }

            do {
                let topAnimeMain = try JSONDecoder().decode(TopAnimesResponseDTO.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(topAnimeMain.top.map{$0.toDomain()}))
                }
            }
            catch let error {
                print("TopAnimeService: Fetch Error - \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: SEARCH ANIMES
    var currentSearchDataTask: URLSessionTask?
    
    func fetchSearch(page: Int, query: String, completion: @escaping (Result<SearchAnimeMain, Error>) -> Void) {
        currentSearchDataTask?.cancel()
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            completion(.success(SearchAnimeMain(animes: [], lastPage: 1)))
            return
        }
        
        let endpointURL = apiPath.search(page: page, query: query)
        print("Search Fetch URL: \(endpointURL)")
        

        currentSearchDataTask = networkManager.request(url: endpointURL) { (data,error) in
            guard let data = data else {
                print("SearchAnimeService: Unable to retrive data")
                return
            }
            
            do {
                let searchReponseDTO = try JSONDecoder().decode(SearchAnimesResponseDTO.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(searchReponseDTO.toDomain()))
                }
            }
            catch let error {
                print("SearchAnimeService: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: GENRE ANIMES
    func fetchGenre(id: Int, page: Int, completion: @escaping (Result<GenreAnimeMain, Error>) -> Void) {
        let endpointURL = apiPath.genre(id: id, page: page)
        print("Genre Fetch URL: \(endpointURL)")
        
        networkManager.request(url: endpointURL) { (data,error)  in
            guard let data = data else {
                print("GenreAnimeServicve: Unable to retrive data")
                return
            }
            
            do {
                let genreReponseDTO = try JSONDecoder().decode(GenreAnimesResponseDTO.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(genreReponseDTO.toDomain()))
                }
            }
            catch let error {
                print("GenreAnimeService: Fetch error \(error)")
                completion(.failure(error))
            }
        }
    }
    
    
    
}
