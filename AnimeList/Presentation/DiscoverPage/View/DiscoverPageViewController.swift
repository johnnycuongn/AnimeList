//
//  SearchPageViewController.swift
//  AnimeList
//
//  Created by Johnny on 15/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit



class DiscoverPageViewController: UIViewController {

    
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

