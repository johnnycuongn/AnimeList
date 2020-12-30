//
//  SearchAnimesPageFlowCoordinatoor.swift
//  AnimeList
//
//  Created by Johnny on 30/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import  UIKit

protocol SearchAnimesPageFlowCoordinatoor {
    func showSearchPage(with viewModel: SearchAnimesPageViewModel)
    func showAnimeDetails(id: Int)
}

class DefaultSearchAnimesPageFlowCoordinatoor: SearchAnimesPageFlowCoordinatoor {
    
    private weak var navigationController: UINavigationController?
    private var animeDetailsFlow: AnimeDetailsFlowCoordinatoor
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        
        self.animeDetailsFlow = DefaultAnimeDetailsFlowCoordinatoor(navigationController: navigationController)
    
    }
    
    func showSearchPage(with viewModel: SearchAnimesPageViewModel) {
        let searchVC = SeachAnimesViewController.create(with: viewModel)
        
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func showAnimeDetails(id: Int) {
        animeDetailsFlow.showAnimeDetails(id: id)
    }
    
}
