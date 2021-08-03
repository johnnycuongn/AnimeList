//
//  SearchPageViewController.swift
//  AnimeList
//
//  Created by Johnny on 15/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit



class DiscoverPageViewController: UIViewController {
    
    static func create() -> DiscoverPageViewController {
        let storyboard = UIStoryboard.main
        guard let vc = storyboard.instantiateViewController(identifier: String(describing: self)) as? DiscoverPageViewController else {
            fatalError("Can't instantiate TopVC")
        }
        
        return vc
    }

    
    @IBOutlet weak var pageCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var genres = Genre.allCases
    
    var viewModel: DiscoverPageViewModel!
    
    func loadController(with viewModel: DiscoverPageViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {

        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
       
    }
}

