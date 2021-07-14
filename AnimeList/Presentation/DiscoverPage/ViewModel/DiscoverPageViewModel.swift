//
//  DiscoverPageViewModel.swift
//  AnimeList
//
//  Created by Johnny on 14/7/21.
//  Copyright © 2021 Johnny. All rights reserved.
//

import Foundation

protocol DiscoverPageViewModel {
    func didSelectGenre(at index: Int)
}

class DefaultDiscoverPageViewModel: DiscoverPageViewModel {
    
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func didSelectGenre(at index: Int) {
        let genreID = Genre.allCases[index].rawValue
        coordinator.showGenreAnimes(genreID: genreID)
    }
    
}
