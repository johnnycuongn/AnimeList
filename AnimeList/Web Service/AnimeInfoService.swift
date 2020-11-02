//
//  AnimeInfoService.swift
//  AnimeList
//
//  Created by Johnny on 25/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class AnimeInfoService {
    private init() {}
    static let shared = AnimeInfoService()
    
    let networkManager: Networking = NetworkManager()
    let path: APIPath = JikanAnimeAPI()
    
    func fetchAnime(id: Int, completion: @escaping (AnimeInfo) -> Void) {
        
        let url = path.anime(id: id)
        print("Fetch Anime URL - \(url)")
        
        networkManager.request(url: url) { (data) in
            guard let data = data else {
                print("AnimeInfoService: Unable to retrieve data")
                return
            }
            
            do {
                let anime = try JSONDecoder().decode(AnimeInfo.self, from: data)
            
                DispatchQueue.main.async {
                    completion(anime)
                }
            }
            catch let error {
                print("Anime Fetch Error: \(error)")
            }
        }
    }
}
