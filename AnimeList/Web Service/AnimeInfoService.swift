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
    
    let animeURL = URL(string: jikanAPI + "/anime")!
    
    func fetchAnime(id: Int, completion: @escaping (AnimeInfo) -> Void) {
        let url = animeURL.appendingPathComponent(String(id))
        
        print("Fetch Anime URL - \(url)")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                try validate(response)
                
                let anime = try JSONDecoder().decode(AnimeInfo.self, from: data)
                
                DispatchQueue.main.async {
                    completion(anime)
                }
                
            }
            catch {
                print("Anime Fetch Error: \(error)")
            }
        }
        .resume()
        
    }
}
