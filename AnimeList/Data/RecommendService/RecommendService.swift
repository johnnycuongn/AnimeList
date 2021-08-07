//
//  RecommendService.swift
//  AnimeList
//
//  Created by Johnny on 3/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class RecommendService {
    private init() {}
    static let shared = RecommendService()
    
    private func topRecommend() -> Int {
        // AnimeTopSubtype.bydefault
        // AnimeTopSubtype.bypopularity
        // AnimeTopSubtype.favorite
        var page = Int.random(in: 1...100)
        
        return 1
    }
    
    func recommendID(_ completion: @escaping (Int) -> Void) {
        
        var id: Int!
        let subtypes: [AnimeTopSubtype] = [.bydefault, .bypopularity, .favorite, .tv, .movie]
        let page = Int.random(in: 1...5)
        let subtype: AnimeTopSubtype = subtypes[Int.random(in: 0..<subtypes.count)]
        
        let animeWS: AnimeFetchRepository = DefaultAnimeFetchRepository()
        animeWS.fetchTop(page: page, subtype: subtype) { (result) in
            switch result {
            case .success(let topAnimes):
                id = topAnimes[Int.random(in: 0..<50)].malID
                completion(id)
            case .failure(let error):
                print("Recommend Error: \(error)")
            }
        }
        
    }
    
    func getGenreStatistic(allAnimes: [AnimeDetails]) {
        let allGenres = allAnimes.flatMap { $0.genres }
        var genresCount: [String: Int] = [:]
        
        for genre in allGenres {
            if genresCount.contains(where: { key, value in
                key == genre.name
            }) {
                let currentCount = genresCount[genre.name]!
                genresCount[genre.name] = (currentCount + 1)
            } else {
                genresCount[genre.name] = 1
            }
        }
        
        print("My Genres Count: \(genresCount)")
    }
    
    func getStudioStatistic(allAnimes: [AnimeDetails]) {
        let allStudios = allAnimes.flatMap { $0.studios }
        var studiosCount: [String: Int] = [:]
        
        for studio in allStudios {
            if studiosCount.contains(where: { key, value in
                key == studio
            }) {
                let currentCount = studiosCount[studio]!
                studiosCount[studio] = (currentCount + 1)
            } else {
                studiosCount[studio] = 1
            }
        }
        
        print("My Studio Count: \(studiosCount)")
    }
    
    func statistic(user: String) {
        var myAnimeList: [AnimeDetails] = [] {
            didSet {
                getGenreStatistic(allAnimes: myAnimeList)
            }
        }
        
        let animeWS = DefaultAnimeFetchRepository()
        animeWS.fetchUserAnime(user: user) { result in
            switch result {
            case .success(let userAnimes):
                fetchEachAnime(IDs: userAnimes.map({ $0.malID})) { animesDetailsArray in
                    myAnimeList.append(contentsOf: animesDetailsArray)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
        func fetchEachAnime(IDs: [Int], completion: @escaping ([AnimeDetails]) -> Void) {
            let group = DispatchGroup()
            
            var animes = [AnimeDetails]()
            var unableToFetchID = [Int]()
            
            for animeID in IDs {
                group.enter()
                    animeWS.fetchAnimeDetails(id: animeID) { result in
                        switch result {
                        case .success(let anime):
                            animes.append(anime)
                            print("Success append anime: \(anime.malID)")
                        case .failure(let error):
                            unableToFetchID.append(animeID)
                        }
                        group.leave()
                    }
            }
            group.notify(queue: DispatchQueue.global()) {
                if !unableToFetchID.isEmpty {
                    fetchEachAnime(IDs: unableToFetchID, completion: completion)
                }
                print("Group Completed")
                completion(animes)
            }
            
        }
    }
    
}
