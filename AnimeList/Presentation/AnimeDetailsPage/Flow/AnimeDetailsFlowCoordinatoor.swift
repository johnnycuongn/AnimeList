//
//  AnimeDetailsFlowCoordinatoor.swift
//  AnimeList
//
//  Created by Johnny on 30/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

protocol AnimeDetailsFlowCoordinatoor {
    func showAnimeDetails(id: Int)
}

class DefaultAnimeDetailsFlowCoordinatoor: AnimeDetailsFlowCoordinatoor {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showAnimeDetails(id: Int) {
        weak var animeVC = AnimeDetailsViewController.initialize(with: id)
        guard animeVC != nil else { return }
        
        print("Select Anime: \(id) - nav: \(String(describing: navigationController))")
        
        navigationController?.pushViewController(animeVC!, animated: true)
    }
    
}
