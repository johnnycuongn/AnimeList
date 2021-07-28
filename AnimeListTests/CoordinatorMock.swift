//
//  CoordinatorMock.swift
//  AnimeListTests
//
//  Created by Johnny on 28/7/21.
//  Copyright © 2021 Johnny. All rights reserved.
//

import Foundation
import UIKit
@testable import AnimeList

class CoordinatorMock: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    var isStart = true
    var animeDetailsCall: Int = 0
    var genreCallID: Int = 0
    var isSearch = false
    
    func start() {
        isStart = true
    }
    
    func closeAnimeDetails() {
        animeDetailsCall -= 1
    }
    
    func showSearch() {
        isSearch = true
    }
    
    func showGenreAnimes(genreID: Int) {
        genreCallID = genreID
    }
    
    func showAnimeDetails(id: Int) {
        animeDetailsCall += 1
    }
}
