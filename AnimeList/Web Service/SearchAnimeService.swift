//
//  SearchAnimeService.swift
//  AnimeList
//
//  Created by Johnny on 15/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

enum SearchParameter: String {
    case q
    case page
    case type
    case genre
    case orderBy = "order_by"
    case members
    case letter
}

class SearchAnimeService {
    private init() {}
    static let shared = SearchAnimeService()
    
    let networkManager: Networking = NetworkManager()
    
    let searchURL = URL(string: jikanAPI + "/search/anime")!
    
    func fetchSearch(page: Int = 1, text: String, completion: @escaping (SearchAnimeMain) -> Void) {
        
        
        let query: [SearchParameter: String]
        guard text.count != 0 else { return }
        
        if text.count == 1 {
            query = [
                .page : String(page),
                .letter: text,
                .orderBy: "members"
            ]
        }
        else {
            query = [
                .q : text,
                .page: String(page)
                
            ]
        }
        
    
        let fetchURL = searchURL.withQueries(query)!
        print("Search Fetch URL: \(fetchURL)")
        
        networkManager.request(url: fetchURL) { (data) in
            guard let data = data else {
                print("SearchAnimeService: Unable to retrive data")
                return
            }
            
            do {
                let searchMain = try JSONDecoder().decode(SearchAnimeMain.self, from: data)
                
                DispatchQueue.main.async {
                    completion(searchMain)
                }
            }
            catch let error {
                print("SearchAnimeService: \(error)")
            }
        }
    }
    
}
