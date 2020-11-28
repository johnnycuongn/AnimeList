//
//  SearchPageViewController.swift
//  AnimeList
//
//  Created by Johnny on 15/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

enum Genre: Int, CaseIterable {
    case Action = 1
    case Adventure
    case Cars
    case Comedy
    case Dementia, Demons, Mystery, Drama, Ecchi, Fantasy, Game, Hentai, Historical, Horror, Kids, Magic, Mecha, Music, Parody, Samurai, Romance, School, Scifi, Shoujo, ShoujiAi, Shounen, ShounenAi, Space, Sports, SuperPower, Vampire, Yaoi, Yuri, Harem, SliceOfLife, SuperNatural, Military, Police, Psychological, Thriller, Seinen, Josei
}

class SearchPageViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pageCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    struct PageState {
        static var isSearching = false
    }
    
    var genres = Genre.allCases
    
    var animes: [AnimeDisplayInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.pageCollectionView.reloadData()
            }
        }
    }
    
    struct Searching {
        static var currentText: String = ""
        static var lastPage: Int = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
       
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
        
        SearchAnimeService.shared.fetchSearch(text: textFetch.lowercased()) { [weak self] (searchMain) in
            guard let strongSelf = self else { return }
//            strongSelf.
            
            Searching.lastPage = searchMain.lastPage
            
            // Problem: Search two words return empty
            // Solution:
            if searchMain.results.isEmpty && text.contains(Searching.currentText) {
                strongSelf.animes = strongSelf.animes.filter({ (searchAnime) -> Bool in
                    let titleMatch = searchAnime.title.range(of: text, options: .caseInsensitive)
                    return titleMatch != nil
                })
            }
            else {
                strongSelf.animes = searchMain.results
            }
            
            Searching.currentText = text
            strongSelf.activityIndicator.stopAnimating()
        }
    }
    
    func loadPageForCurrentSearch(page: Int) {
        guard page <= Searching.lastPage else { return }
        
        SearchAnimeService.shared.fetchSearch(page: page, text: Searching.currentText) { (searchMain) in
            self.animes.append(contentsOf: searchMain.results)
        }
    }
}

extension SearchPageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil {
            PageState.isSearching = false
            self.pageCollectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == "" || searchBar.text == nil {
            PageState.isSearching = false
            self.pageCollectionView.reloadData()
        } else {
            PageState.isSearching = true
            self.loadNewSearch(text: searchBar.text!)
        }
        
        searchBar.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
}
