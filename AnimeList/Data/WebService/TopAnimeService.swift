//
//  TopAnimeService.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation



public let jikanAPI = "https://api.jikan.moe/v3"

class TopAnimeService {
    private init () {}
    static let shared = TopAnimeService()
    
    let networkManager: Networking = NetworkManager()
    let path: APIPath = JikanAnimeAPI()
    
    static let numberOfItemsLoad = 50
    
    let topAnimeURL = URL(string: jikanAPI + "/top/anime")!
    
    func fetchAllForCache() {
        
    }
    
    func fetchTopAnime(page: Int = 1, subtype: AnimeTopSubtype, completion: @escaping ([TopAnimeDTO]) -> Void ) {
        
        let fetchURL = path.top(at: page, subtype: subtype)
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

