//
//  TopViewController.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

struct AnimeOfPage {
    var page: Int
    var anime: [TopAnimeDTO]
}



class TopViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var topSubtypeDataService: TopSubtypeDataService!
    @IBOutlet weak var topSubtypeCollectionView: UICollectionView!
    
    @IBOutlet weak var topAnimeCollectionView: UICollectionView!
    
    var viewModel: TopAnimesPageViewModel!
    let pageThumbnailCell = AnimeThumbnailCell.self
    
    func create(viewModel: TopAnimesPageViewModel =  DefaultTopAnimesPageViewModel()) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.create()
        bind(to: self.viewModel)

        
        topSubtypeCollectionView.dataSource = topSubtypeDataService
        topSubtypeCollectionView.delegate = topSubtypeDataService
        topSubtypeDataService.delegate = self
        
        
        topAnimeCollectionView.delegate = self
        topAnimeCollectionView.dataSource = self
        topAnimeCollectionView.register(UINib(nibName: pageThumbnailCell.identifier, bundle: nil), forCellWithReuseIdentifier:  pageThumbnailCell.identifier)
        topAnimeCollectionView.scrollsToTop = true
        
        
        self.tabBarController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        topSubtypeCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
    }
    
    private func bind(to viewModel: TopAnimesPageViewModel) {
        viewModel.topAnimes.observe(on: self) { [weak self] in self?.updateCollectionView($0) }
        viewModel.loadingStyle.observe(on: self) { [weak self] in self?.updateLoading($0)}
        viewModel.error.observe(on: self) { [weak self] in self?.updateError($0) }
    }
    
    private func updateError(_ error: String?) {
        guard let error = error, !error.isEmpty else { return }
        print("TopVC Error: \(error)")
    }
    
    private func updateCollectionView(_ animes: [TopAnimeThumbnailViewModel]) {
        if animes.isEmpty {
            self.topAnimeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        self.topAnimeCollectionView.reloadData()
    }

    private func updateLoading(_ loadingStyle: LoadingStyle?) {
        switch loadingStyle {
        case .fullscreen:
            self.activityIndicator.startAnimating()
        case .none:
            self.activityIndicator.stopAnimating()
        }
    }
    
}

extension TopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return pageThumbnailCell.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 10, right: 8)
    }
}

extension TopViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.selectedIndex
        
        if selectedIndex == 0 {
            self.topAnimeCollectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}
