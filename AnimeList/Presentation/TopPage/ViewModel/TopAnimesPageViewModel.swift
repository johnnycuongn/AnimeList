//
//  TopAnimesViewModel.swift
//  AnimeList
//
//  Created by Johnny on 28/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

enum LoadingStyle {
    case fullscreen
}

protocol TopAnimesPageViewModel {
    var currentSubtype: AnimeTopSubtype { get set }
    var topAnimes: Observable<[TopAnimeDTO]> { get set }
    var loadingStyle: Observable<LoadingStyle?> { get set }
    
    var didLoadedPages: Int { get }
    
    func loadAnimes(page: Int, subtype: AnimeTopSubtype)
    func loadNextPage(at indexPath: IndexPath)
    func didSelect(subtype: AnimeTopSubtype)
    func topAnimeDisplayViewModel(at indexPath: IndexPath) -> TopAnimeThumbnailViewModel
}

// MARK: - Default Implementation
class DefaultTopAnimesPageViewModel: TopAnimesPageViewModel {
    
    var currentSubtype: AnimeTopSubtype = .bydefault
    var topAnimes: Observable<[TopAnimeDTO]> = Observable([])
    
    var didLoadedPages: Int {
        return topAnimes.value.count / TopAnimeService.numberOfItemsLoad
    }
    
    var loadingStyle: Observable<LoadingStyle?> = Observable(.none)
    
    init() {
        loadAnimes(page: 1, subtype: currentSubtype)
    }
    
    /// Fetch top animes from services
    func loadAnimes(page: Int = 1, subtype: AnimeTopSubtype) {
        guard page > didLoadedPages else { return }
        
        loadingStyle.value = .fullscreen
//        TopAnimeService.shared.fetchTopAnime(page: page, subtype: subtype) {
//            [weak self] (topAnimes) in
//                self?.topAnimes.value.append(contentsOf: topAnimes)
//                self?.loadingStyle.value = .none
//        }
        
        let animeService: AnimeWebService = DefaultAnimeWebService()
        
        animeService.fetchTop(page: page, subtype: subtype) { [weak self] (result) in
            switch result {
            case .success(let topAnimes):
                self?.topAnimes.value.append(contentsOf: topAnimes)
                self?.loadingStyle.value = .none
            case .failure(let error):
                print("Top Animes Error: \(error)")
            }
        }
        
    }
    
    func loadNextPage(at indexPath: IndexPath) {
        
        let willLoadedPosition = topAnimes.value.count - 8
        
        if indexPath.row == willLoadedPosition {
            let nextPage = didLoadedPages + 1
            loadAnimes(page: nextPage, subtype: currentSubtype)
        }
    }
    
    func didSelect(subtype: AnimeTopSubtype) {
        guard subtype != currentSubtype else { return }
        
        self.topAnimes.value = []
        self.currentSubtype = subtype
        loadAnimes(subtype: currentSubtype)
    }
    
    func topAnimeDisplayViewModel(at indexPath: IndexPath) -> TopAnimeThumbnailViewModel {
        let topAnime = topAnimes.value[indexPath.row]
        let viewModel = DefaultTopAnimeThumbnailViewModel(animeInfo: topAnime)
        
        return viewModel
    }
}