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
    
    func create(with dependency: BaseDI ) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//
//        guard let tabbarVC = storyBoard.instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { fatalError() }
        
        guard let viewControllers = viewControllers else {
            fatalError() }
        
        for vc in viewControllers {
            (vc as? TopViewController)?
                .loadController(with: dependency.makeTopAnimesPageViewModel())
            
            (vc as? RandomViewController)?
                .loadController(with: dependency.makeRandomPageViewModel())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        create(with: appDIContainer)

    }
    
    
    @IBAction func searchButtonDidTapped(_ sender: UIBarButtonItem) {
        guard let searchVC = SeachAnimesViewController.create() else {
            return
        }
        navigationController?.pushViewController(searchVC, animated: true)
    }
    

}
