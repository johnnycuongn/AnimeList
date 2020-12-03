//
//  BaseTabBarController.swift
//  AnimeList
//
//  Created by Johnny on 3/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func searchButtonDidTapped(_ sender: UIBarButtonItem) {
        guard let searchVC = SeachAnimesViewController.create() else {
            return
        }
        navigationController?.pushViewController(searchVC, animated: true)
    }
    

}
