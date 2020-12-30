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
    
    var appDIContainer = AppDelegate.appDIContainer
    lazy var appFlowCoordinatoor = AppFlowCoordinatoor(navigationController: navigationController)
    
    static func create() -> BaseTabBarController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let tabbarVC = storyBoard.instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { fatalError() }
        
        return tabbarVC
    }
    
        
    func startFlow(with dependency: BaseDI, navigationController: UINavigationController) {

        guard let baseViewControllers = viewControllers else {
            fatalError() }
        
        func loadControllers(_ viewControllers: [UIViewController]) {
            for vc in viewControllers {
                (vc as? TopViewController)?
                    .loadController(with: dependency.makeTopAnimesPageViewModel(flow: topPageFlow))
                
                (vc as? RandomViewController)?
                    .loadController(with: dependency.makeRandomPageViewModel())
            }
        }
        
        loadControllers(baseViewControllers)
    }
    
    var topPageFlow: TopAnimesPageFlowCoordinator!

    var searchAnimesPageFlow: SearchAnimesPageFlowCoordinatoor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let baseNavigation = self.navigationController else {return}
        
        topPageFlow = appFlowCoordinatoor.topPage
        searchAnimesPageFlow = appFlowCoordinatoor.searchPage
        
        startFlow(with: appDIContainer, navigationController: baseNavigation)

    }
    
    
    @IBAction func searchButtonDidTapped(_ sender: UIBarButtonItem) {
        let searchVC = appDIContainer.makeSearchAnimesViewController(flow: searchAnimesPageFlow)
        
        navigationController?.pushViewController(searchVC, animated: true)
    }
    

}
