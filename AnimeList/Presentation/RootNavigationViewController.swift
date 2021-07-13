//
//  NavigationViewController.swift
//  AnimeList
//
//  Created by Johnny on 29/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class RootNavigationViewController: UINavigationController {
    
    static func create() -> RootNavigationViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "RootNavigationViewController") as? RootNavigationViewController else {
            fatalError("Can't instantiate \(String(describing: self))")
        }
        
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
