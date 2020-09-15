//
//  URLExtensions.swift
//  AnimeList
//
//  Created by Johnny on 15/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [SearchParameter: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key.rawValue , value: $0.value ) }
        return components?.url
    }
}
