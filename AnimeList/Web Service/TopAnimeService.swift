//
//  TopAnimeService.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

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

public let jikanAPI = "https://api.jikan.moe/v3"

class TopAnimeService {
    private init () {}
    static let shared = TopAnimeService()
    
    let networkManager: Networking = NetworkManager()
    
    static let numberOfItemsLoad = 50
    
    let topAnimeURL = URL(string: jikanAPI + "/top/anime")!
    
    func fetchAllForCache() {
        
    }
    
    func fetchTopAnime(page: Int = 1, subtype: AnimeTopSubtype, completion: @escaping ([TopAnime]) -> Void ) {
        var fetchURL: URL = topAnimeURL.appendingPathComponent(String(page))
        
        switch subtype {
        case .bydefault:
            print()
        case .bypopularity:
            fetchURL = fetchURL.appendingPathComponent("bypopularity")
        default:
            fetchURL = fetchURL.appendingPathComponent(subtype.rawValue.lowercased())
        }
        
        print("Top Fetch URL: \(fetchURL)")
        
        networkManager.request(url: fetchURL) { (data) in
            guard let data = data else {
                print("TopAnimeService: Unable to retrive data")
                return
            }
            
            do {
                let topAnimeMain = try JSONDecoder().decode(TopAnimeMain.self, from: data)
                
                DispatchQueue.main.async {
                    completion(topAnimeMain.top)
                }
            }
            catch let error {
                print("TopAnimeService: Fetch Error - \(error)")
            }
        }
    }
    
    
    
    
    
}

