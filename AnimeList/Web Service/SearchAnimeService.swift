//
//  SearchAnimeService.swift
//  AnimeList
//
//  Created by Johnny on 15/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    func withQueries(_ queries: [SearchParameter: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key.rawValue , value: $0.value ) }
        return components?.url
    }
}

enum SearchParameter: String {
    case q
    case page
    case type
    case genre
    case orderBy = "order_by"
    case members
    case letter
}

class SearchMain: Decodable {
    var results: [AnimeDisplayInfo]
    var lastPage: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case lastPage = "last_page"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.results = try container.decode([AnimeDisplayInfo].self, forKey: .results)
        self.lastPage = try container.decode(Int.self, forKey: .lastPage)
    }
}

class SearchAnimeService {
    private init() {}
    
    static let shared = SearchAnimeService()
    
    let searchURL = URL(string: jikanStartAPI + "/search/anime")!
    
    func fetchSearch(page: Int = 1, text: String, completion: @escaping (SearchMain) -> Void) {
        
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
                
                let searchMain = try JSONDecoder().decode(SearchMain.self, from: searchData)
                
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
