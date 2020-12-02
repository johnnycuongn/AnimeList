//
//  NetworkManager.swift
//  AnimeList
//
//  Created by Johnny on 26/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case failedToFetchData
}

protocol Networking {
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkManager: Networking {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            do {
                try validate(response)

                guard error == nil else {
                    print("Network Error: \(String(describing: error))")
                    completion(nil, error)
                    return
                }
                
                DispatchQueue.main.async {
                    completion(data, nil)
                }
                
            }
            catch let error {
                // TODO: Catch reponse error
                completion(nil, error)
                print("Network Validation Error: \(error)")
            }
        }.resume()
    }
}
