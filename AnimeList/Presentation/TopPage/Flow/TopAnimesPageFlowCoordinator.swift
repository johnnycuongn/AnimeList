//
//  TopAnimesPageFlowCoordinator.swift
//  AnimeList
//
//  Created by Johnny on 29/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

protocol TopAnimesPageFlowCoordinator {
    func showAnimeDetails(id: Int)
}

class DefaultTopAnimesPageFlowCoordinator: TopAnimesPageFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private var animeDetailsFlow: AnimeDetailsFlowCoordinatoor
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        
        self.animeDetailsFlow = DefaultAnimeDetailsFlowCoordinatoor(navigationController: navigationController)
    
    }
    
    func showAnimeDetails(id: Int) {
        animeDetailsFlow.showAnimeDetails(id: id)
    }
    
}
