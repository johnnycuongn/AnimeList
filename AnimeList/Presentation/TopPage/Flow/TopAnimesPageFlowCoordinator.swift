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
    var topAnimeAction: TopAnimesPageViewModelAction { get }
}

class DefaultTopAnimesPageFlowCoordinator: TopAnimesPageFlowCoordinator {
    
    let dependency = AppDIContainer()
    
    private weak var navigationController: UINavigationController?
    private var animeDetailsFlow: AnimeDetailsFlowCoordinatoor
    
    var topAnimeAction: TopAnimesPageViewModelAction
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        
        self.animeDetailsFlow = DefaultAnimeDetailsFlowCoordinatoor(navigationController: navigationController)
        
        self.topAnimeAction = TopAnimesPageViewModelAction(showAnimeDetails: animeDetailsFlow.showAnimeDetails)
    }
    
}
