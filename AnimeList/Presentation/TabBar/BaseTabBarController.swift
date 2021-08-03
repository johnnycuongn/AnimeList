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
    
    var appDIContainer = SceneDelegate.appDIContainer
    
    weak var coordinator: AppFlowCoordinatoor?
    
    static func create() -> BaseTabBarController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let tabbarVC = storyBoard.instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { fatalError() }
        
        return tabbarVC
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [
            appDIContainer.makeTopViewController(),
            appDIContainer.makeDiscoverPageViewController(),
            appDIContainer.makeRandomViewController()
        ]

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    @IBAction func searchButtonDidTapped(_ sender: UIBarButtonItem) {
        coordinator?.showSearch()
    }
    

}
