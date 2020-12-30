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
    
    static func initialize() -> BaseTabBarController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let tabbarVC = storyBoard.instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { fatalError() }
        
        return tabbarVC
    }
    
    func startFlow(with dependency: BaseDI, navigationController: UINavigationController) {

        guard let baseViewControllers = viewControllers else {
            fatalError() }
        
        let topFlow = appDIContainer.makeTopAnimesPageFlowCoordinatoor(navigationController: navigationController)
        
        func loadControllers(_ viewControllers: [UIViewController]) {
            for vc in viewControllers {
                (vc as? TopViewController)?
                    .loadController(with: dependency.makeTopAnimesPageViewModel(flow: topFlow))
                
                (vc as? RandomViewController)?
                    .loadController(with: dependency.makeRandomPageViewModel())
            }
        }
        
        loadControllers(baseViewControllers)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let baseNavigation = self.navigationController else {return}
        
        startFlow(with: appDIContainer, navigationController: baseNavigation)

    }
    
    
    @IBAction func searchButtonDidTapped(_ sender: UIBarButtonItem) {
        guard let searchVC = SeachAnimesViewController.create() else {
            return
        }
        navigationController?.pushViewController(searchVC, animated: true)
    }
    

}
