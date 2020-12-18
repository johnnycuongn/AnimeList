//
//  BaseTabBarController.swift
//  AnimeList
//
//  Created by Johnny on 3/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    
    var appDIContainer = AppDIContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewControllers = self.viewControllers else { return }
        
        for vc in viewControllers {
            (vc as? TopViewController)?
                .loadController(with: appDIContainer.makeTopAnimesPageViewModel())
            
            (vc as? RandomViewController)?
                .loadController(with: appDIContainer.makeRandomPageViewModel())
        }

    }
    
    
    @IBAction func searchButtonDidTapped(_ sender: UIBarButtonItem) {
        guard let searchVC = SeachAnimesViewController.create() else {
            return
        }
        navigationController?.pushViewController(searchVC, animated: true)
    }
    

}
