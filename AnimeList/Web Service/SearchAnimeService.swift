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
        
        URLSession.shared.dataTask(with: fetchURL) { (data, response, error) in
            guard let searchData = data else { return }
            do {
                try validate(response)
                
                let searchMain = try JSONDecoder().decode(SearchAnimeMain.self, from: searchData)
                
                DispatchQueue.main.async {
                    completion(searchMain)
                }
            }
            catch {
                print("Search Fetch Error: \(error)")
            }
        }.resume()
        
        
    }
    
}
