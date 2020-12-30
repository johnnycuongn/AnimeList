//
//  AppFlowCoordinatoor.swift
//  AnimeList
//
//  Created by Johnny on 30/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

class AppFlowCoordinatoor {
    

    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController?) {
        guard let navigationController = navigationController else {
            fatalError("Can't Found Navigation Controller in \(String(describing: AppFlowCoordinatoor.self))")
        }
        
        self.navigationController = navigationController
    }
    
    var topPage: TopAnimesPageFlowCoordinator {
        return makeTopAnimesPageFlowCoordinatoor(navigationController: navigationController)
    }
    
    var searchPage: SearchAnimesPageFlowCoordinatoor {
        return makeSearchAnimesPageFlowCoordinatoor(navigationController: navigationController)
    }
    
    
    // MARK: private 'Make' method
    
    private func makeTopAnimesPageFlowCoordinatoor(navigationController: UINavigationController) -> TopAnimesPageFlowCoordinator {
        return DefaultTopAnimesPageFlowCoordinator(navigationController: navigationController)
    }
    
    private func makeSearchAnimesPageFlowCoordinatoor(navigationController: UINavigationController) -> SearchAnimesPageFlowCoordinatoor {
        return DefaultSearchAnimesPageFlowCoordinatoor(navigationController: navigationController)
    }
    
}
