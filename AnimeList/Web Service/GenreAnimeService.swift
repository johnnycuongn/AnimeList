//
//  GenreAnimeService.swift
//  AnimeList
//
//  Created by Johnny on 23/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

class GenreAnimeService {
    private init () {}
    static let shared = GenreAnimeService()
    
    private let genreURL = URL(string: jikanAPI + "/genre/anime")!
    
    func fetchGenre(id: Int, page: Int = 1, completion: @escaping (GenreAnimeMain) -> Void) {
        let fetchURL: URL = genreURL.appendingPathComponent(String(id))
                            .appendingPathComponent(String(page))
        
        print("Genre Fetch URL: \(fetchURL)")
        
        URLSession.shared.dataTask(with: fetchURL) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                try validate(response)
                
                let genreAnimeMain = try JSONDecoder().decode(GenreAnimeMain.self, from: data)
                
                DispatchQueue.main.async {
                    completion(genreAnimeMain)
                }
            }
                
            catch {
                print("Top Fetch Error: \(error)")
            }
        }
        .resume()
    }
}
