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
        
        return searchVC
    }
    
    var searchBar = UISearchBar()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var lastPage: Int = 1
    var currentText = ""
    
    var animes: [AnimeThumbnailDTO] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
//        searchBar.becomeFirstResponder()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: SearchCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchCell.identifier)
        
        collectionView.scrollsToTop = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.searchTextField.becomeFirstResponder()
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
            self.loadNewSearch(text: searchBar.text!)
        }
        
        searchBar.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    @objc func loadNewSearch(text: String) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        let textFetch: String = {
            var textResult = text
            if text.count == 2 {
                textResult = String(text.prefix(1))
            }
            
            return textResult
        }()
        
//        SearchAnimeService.shared.fetchSearch(text: textFetch.lowercased()) { [weak self] (searchMain) in
//            guard let strongSelf = self else { return }
//
//            strongSelf.lastPage = searchMain.lastPage
//
//            // Problem: Search two words return empty
//            // Solution:
//            if searchMain.results.isEmpty && text.contains(strongSelf.currentText) {
//                strongSelf.animes = strongSelf.animes.filter({ (searchAnime) -> Bool in
//                    let titleMatch = searchAnime.title.range(of: text, options: .caseInsensitive)
//                    return titleMatch != nil
//                })
//            }
//            else {
//                strongSelf.animes = searchMain.results
//            }
//
//            strongSelf.currentText = text
//            strongSelf.activityIndicator.stopAnimating()
//        }
        let animeWS: AnimeWebService = DefaultAnimeWebService()
        animeWS.fetchSearch(page: 1, query: textFetch.lowercased()) { [weak self] (result) in
            switch result {
            case .success(let searchMain):
                guard let strongSelf = self else { return }
                strongSelf.lastPage = searchMain.lastPage
                
                // Problem: Search two words return empty
                // Solution:
                if searchMain.results.isEmpty && text.contains(strongSelf.currentText) {
                    strongSelf.animes = strongSelf.animes.filter({ (searchAnime) -> Bool in
                        let titleMatch = searchAnime.title.range(of: text, options: .caseInsensitive)
                        return titleMatch != nil
                    })
                }
                else {
                    strongSelf.animes = searchMain.results
                }
                
                strongSelf.currentText = text
                strongSelf.activityIndicator.stopAnimating()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func loadPageForCurrentSearch(page: Int) {
        guard page <= lastPage else { return }
        
        let animeWS: AnimeWebService = DefaultAnimeWebService()
        animeWS.fetchSearch(page: page, query: currentText) { [weak self] (result) in
            switch result {
            case .success(let searchMain):
                self?.animes.append(contentsOf: searchMain.results)
            case .failure(let error):
                print("Search Error: \(error)")
            }
            
        }
    }
}


