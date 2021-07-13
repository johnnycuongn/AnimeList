//
//  AppFlowCoordinatoor.swift
//  AnimeList
//
//  Created by Johnny on 30/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

protocol PageCoordinatoor {
    func showAnimeDetail(id: Int)
    func showSearch()
}

protocol Coordinator: AnyObject, PageCoordinatoor {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}


class AppFlowCoordinatoor: Coordinator {
    
    private let appDIContainer = SceneDelegate.appDIContainer
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    private let baseVC = BaseTabBarController.create()
    
    init(navigationController: UINavigationController?) {
        guard let navigationController = navigationController else {
            fatalError("Can't Found Navigation Controller in \(String(describing: AppFlowCoordinatoor.self))")
        }
        
        self.navigationController = navigationController
        self.childCoordinators = []
        
    }
    
    func start() {
        baseVC.coordinator = self
        navigationController.pushViewController(baseVC, animated: false)
    }
    
    func showAnimeDetail(id: Int) {
        weak var animeVC =
            AnimeDetailsViewController.initialize(with: id)
        guard animeVC != nil else { return }
        
        navigationController.pushViewController(animeVC!, animated: true)
    }
    
    func showSearch() {
        weak var searchVC = appDIContainer.makeSearchAnimesViewController()
        guard searchVC != nil else { return }
        
        navigationController.pushViewController(searchVC!, animated: true)
    }
    
}
