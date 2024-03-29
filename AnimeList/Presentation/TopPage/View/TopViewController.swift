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
    
    func loadController(with viewModel: TopAnimesPageViewModel) {
        self.viewModel = viewModel
    }
    
    static func create(with viewModel: TopAnimesPageViewModel) -> TopViewController {
        let storyboard = UIStoryboard.main
        guard let vc = storyboard.instantiateViewController(identifier: String(describing: self)) as? TopViewController else {
            fatalError("Can't instantiate TopVC")
        }
        
        vc.viewModel = viewModel
        
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.create()
        bind(to: self.viewModel)
        viewModel.loadAnimes(page: 1, subtype: viewModel.currentSubtype)

        
        topSubtypeCollectionView.dataSource = topSubtypeDataService
        topSubtypeCollectionView.delegate = topSubtypeDataService
        topSubtypeDataService.delegate = self
        
        
        topAnimeCollectionView.delegate = self
        topAnimeCollectionView.dataSource = self
        topAnimeCollectionView.register(UINib(nibName: pageThumbnailCell.identifier, bundle: nil), forCellWithReuseIdentifier:  pageThumbnailCell.identifier)
        topAnimeCollectionView.scrollsToTop = true
        
        topAnimeCollectionView.refreshControl = UIRefreshControl()
        topAnimeCollectionView.refreshControl?.addTarget(self, action: #selector(self.reloadPage), for: .valueChanged)
        
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
        guard let error = error else {
            topAnimeCollectionView.backgroundView = nil
            return }
        
        let errorView = ErrorView().loadNib() as? ErrorView
        errorView?.delegate = self
        errorView?.errorLabel.text = error
        
        topAnimeCollectionView.backgroundView = errorView
        
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
            self.topAnimeCollectionView.backgroundView = nil
            self.activityIndicator.startAnimating()
        case .none:
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc func reloadPage() {
        viewModel.topAnimes.value = []
        viewModel.loadAnimes(page: 1, subtype: viewModel.currentSubtype)
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

extension TopViewController: ErrorViewDelegate {
    func reload() {
        self.reloadPage()
    }
}
