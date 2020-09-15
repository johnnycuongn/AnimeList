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

public let jikanStartAPI = "https://api.jikan.moe/v3"

class TopAnimeService {
    private init () {}
    
    static let shared = TopAnimeService()
    static let numberOfItemsLoad = 50
    
    let topAnimeURL = URL(string: jikanStartAPI + "/top/anime")!
    
    func fetchTopAnime(page: Int = 1, subtype: AnimeTopSubtype, completion: @escaping ([TopAnimeInfo]) -> Void ) {
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

        URLSession.shared.dataTask(with: fetchURL) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                try validate(response)
                
                let topAnimeMain = try JSONDecoder().decode(TopAnimeMain.self, from: data)
                
                DispatchQueue.main.async {
                    completion(topAnimeMain.top)
                }
                
            }
                
            catch {
                print("TopAnimeSerVice error: \(error)")
            }
        }
        .resume()
    }
    
    
    
    
    
}

