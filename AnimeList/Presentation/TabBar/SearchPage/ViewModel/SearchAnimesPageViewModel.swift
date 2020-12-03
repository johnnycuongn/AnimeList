//
//  SearchAnimesViewModel.swift
//  AnimeList
//
//  Created by Johnny on 2/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

protocol SearchAnimesPageViewModel {
    var lastPage: Int { get }
    var currentSearchText: String { get }
    var loadingStyle: Observable<LoadingStyle?> { get }
    
    var animes: Observable<[AnimeThumbnailDTO]> { get }

    func loadSearch(page: Int, _ text: String)
    func loadSearch(for nextPage: Int)
}

// MARK: -

class DefaultSearchAnimesPageViewModel: SearchAnimesPageViewModel {
    
    var lastPage: Int = 1
    
    var currentSearchText: String = ""
    
    var loadingStyle: Observable<LoadingStyle?> = Observable(.none)
    var animes: Observable<[AnimeThumbnailDTO]> = Observable([])
    
    private let animeWS: SearchAnimeWebService
    
    init(animeWebService: SearchAnimeWebService = DefaultAnimeWebService()) {
        self.animeWS = animeWebService
    }
    
    func loadSearch(page: Int = 1, _ text: String) {
        loadingStyle.value = .fullscreen
        
        let textFetch: String = {
            var textResult = text
            if text.count == 2 {
                textResult = String(text.prefix(1))
            }
            
            return textResult
        }()
        
        animeWS.fetchSearch(page: page, query: textFetch.lowercased()) { [weak self] (result) in
            switch result {
            
            case .success(let searchMain):
                guard let strongSelf = self else { return }
                strongSelf.lastPage = searchMain.lastPage
                
                // Problem: Search two words return empty
                // Solution:
                if searchMain.results.isEmpty && text.contains(strongSelf.currentSearchText) {
                    strongSelf.animes.value = strongSelf.animes.value.filter({ (searchAnime) -> Bool in
                        let titleMatch = searchAnime.title.range(of: text, options: .caseInsensitive)
                        return titleMatch != nil
                    })
                }
                else {
                    strongSelf.animes.value = searchMain.results
                }
                
                strongSelf.currentSearchText = text
                
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
            self?.loadingStyle.value = .none
        }
    }
    
    func loadSearch(for nextPage: Int) {
        guard nextPage > lastPage else { return }
        
        animeWS.fetchSearch(page: nextPage, query: currentSearchText) { [weak self] (result) in
            switch result {
            case .success(let searchMain):
                self?.animes.value.append(contentsOf: searchMain.results)
            case .failure(let error):
                print("Search Error: \(error)")
            }
            
        }
    }
    
}
