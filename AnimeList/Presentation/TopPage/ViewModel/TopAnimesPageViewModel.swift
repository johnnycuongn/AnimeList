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
    var topAnimes: Observable<[TopAnimeThumbnailViewModel]> { get }
    
    var loadingStyle: Observable<LoadingStyle?> { get set }
    var error: Observable<String?> { get }
    
    var didLoadedPages: Int { get }
    
    func loadAnimes(page: Int, subtype: AnimeTopSubtype)
    func loadNextPage(at indexPath: IndexPath)
    func didSelect(subtype: AnimeTopSubtype)
    
    func didSelectAnime(at index: Int)
}

// MARK: - Default Implementation
class DefaultTopAnimesPageViewModel: TopAnimesPageViewModel {
    
    var topAnimes: Observable<[TopAnimeThumbnailViewModel]> = Observable([])

    var currentSubtype: AnimeTopSubtype = .bydefault
    
    var didLoadedPages: Int {
        return topAnimes.value.count / TopAnimeMain.topItemsLoadPerPage
    }
    
    var loadingStyle: Observable<LoadingStyle?> = Observable(.none)
    var error: Observable<String?> = Observable(.none)
    
    private let animeUseCase: TopAnimesReadUseCase

    private var coordinator: Coordinator
    
    init(
        animeUseCase: TopAnimesReadUseCase = DefaultTopAnimesReadUseCase(),
        coordinator: Coordinator
    ) {
        self.animeUseCase = animeUseCase
        self.coordinator = coordinator
    }
    
    /// Fetch top animes from services
    func loadAnimes(page: Int = 1, subtype: AnimeTopSubtype) {
        guard page > didLoadedPages else { return }
        
        loadingStyle.value = .fullscreen
        
        animeUseCase.getAnimes(page: page, subtype: subtype) { [weak self] (result) in
            switch result {
            
            case .success(let topAnimes):
                self?.topAnimes.value.append(contentsOf: topAnimes.compactMap({
                    DefaultTopAnimeThumbnailViewModel.init(animeThumbnail: $0)
                }))
                
                
            case .failure(let error):
                print("Top Animes Error: \(error)")
                self?.handleError(error)
            }
            
            self?.loadingStyle.value = .none
        }
        
    }
    
    fileprivate func handleError(_ error: Error) {
        if let error = error as? HTTPError {
            switch error {
            case .invalidResponse:
                self.error.value = "Unable to load animes"
            default:
                self.error.value = "Failed to load"
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
    
    func didSelectAnime(at index: Int) {
        let selectedAnime = topAnimes.value[index]
        let selectedID = selectedAnime.id
        
        coordinator.showAnimeDetails(id: selectedID)
    }
    
}
