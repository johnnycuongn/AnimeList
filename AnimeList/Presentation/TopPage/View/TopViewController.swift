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
    var anime: [TopAnime]
}

struct TabBarIndex {
    static let topViewController = 0
    static let searchViewController = 1
    static let randomViewController = 1
}

class TopViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var topSubtypeDataService: TopSubtypeDataService!
    @IBOutlet weak var topSubtypeCollectionView: UICollectionView!
    
    @IBOutlet weak var topAnimeCollectionView: UICollectionView!
    
    var viewModel: TopAnimesViewModel!
    
    func create(viewModel: TopAnimesViewModel =  DefaultTopAnimesViewModel()) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: self.viewModel)

        
        topSubtypeCollectionView.dataSource = topSubtypeDataService
        topSubtypeCollectionView.delegate = topSubtypeDataService
        topSubtypeDataService.delegate = self
        
        
        topAnimeCollectionView.delegate = self
        topAnimeCollectionView.dataSource = self
        topAnimeCollectionView.register(UINib(nibName: AnimeDisplayCell.identifier, bundle: nil), forCellWithReuseIdentifier:  AnimeDisplayCell.identifier)
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
    
    private func bind(to viewModel: TopAnimesViewModel) {
        viewModel.topAnimes.observe(on: self) { [weak self] in self?.updateCollectionView($0) }
        viewModel.loadingStyle.observe(on: self) { [weak self] in self?.updateLoading($0)}
    }
    
    private func updateCollectionView(_ animes: [TopAnime]) {
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
        let cellWidth = topAnimeCollectionView.frame.width / 2.2
        let cellHeight = topAnimeCollectionView.frame.height / 2.8
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
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
