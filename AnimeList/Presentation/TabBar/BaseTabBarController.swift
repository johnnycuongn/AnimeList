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
    
    /// Load tab bar's controllers with dependant view model
    func loadControllers(_ viewControllers: [UIViewController]) {
        guard let coordinator = self.coordinator else {
            return
        }
        
        for vc in viewControllers {
            (vc as? TopViewController)?
                .loadController(with: appDIContainer.makeTopAnimesPageViewModel(coordinator: coordinator))
            
            (vc as? RandomViewController)?
                .loadController(with: appDIContainer.makeRandomPageViewModel())
            
            (vc as? DiscoverPageViewController)?
                .loadController(with: appDIContainer.makeDiscoverPageViewModel(coordinator: coordinator))
        }
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let baseViewControllers = viewControllers else {
            fatalError() }
        
        loadControllers(baseViewControllers)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    @IBAction func searchButtonDidTapped(_ sender: UIBarButtonItem) {
        coordinator?.showSearch()
    }
    

}
