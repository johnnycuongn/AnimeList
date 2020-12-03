//
//  SeachAnimesViewController.swift
//  AnimeList
//
//  Created by Johnny on 1/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class SeachAnimesViewController: UIViewController {
    
    static func create() -> SeachAnimesViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let searchVC = storyBoard.instantiateViewController(withIdentifier: "SeachAnimesViewController") as? SeachAnimesViewController else { return nil }
        searchVC.viewModel = DefaultSearchAnimesPageViewModel()
        
        return searchVC
    }
    
    var searchBar = UISearchBar()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: SearchAnimesPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
//        searchBar.becomeFirstResponder()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: SearchCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.scrollsToTop = true
        
        let leftBarButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(cancelSearch))
        leftBarButton.tintColor = AssetColor.superLightGrey
        
        navigationItem.leftBarButtonItem = leftBarButton
        
        bind(to: self.viewModel)

    }
    
    @objc func cancelSearch() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.searchTextField.becomeFirstResponder()
    }
    
    private func bind(to viewModel: SearchAnimesPageViewModel) {
        viewModel.animes.observe(on: self) { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        viewModel.loadingStyle.observe(on: self) { [weak self] in self?.updateLoading($0) }
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

extension SeachAnimesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil {
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == "" || searchBar.text == nil {
            self.collectionView.reloadData()
        } else {
            viewModel.loadSearch(page: 1, searchBar.text!)
        }
        
        searchBar.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}


