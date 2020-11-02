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
    
    let networkManager: Networking = NetworkManager()
    let path: APIPath = JikanAnimeAPI()
    
    func fetchGenre(id: Int, page: Int = 1, completion: @escaping (GenreAnimeMain) -> Void) {
        
        let fetchURL = path.genre(id: id, page: page)
        print("Genre Fetch URL: \(fetchURL)")
        
        networkManager.request(url: fetchURL) { (data) in
            guard let data = data else {
                print("GenreAnimeServicve: Unable to retrive data")
                return
            }
            
            do {
                let genreAnimeMain = try JSONDecoder().decode(GenreAnimeMain.self, from: data)
                
                DispatchQueue.main.async {
                    completion(genreAnimeMain)
                }
            }
            catch let error {
                print("GenreAnimeService: Fetch error \(error)")
            }
        }
    }
}
