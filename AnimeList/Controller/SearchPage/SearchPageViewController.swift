//
//  SearchPageViewController.swift
//  AnimeList
//
//  Created by Johnny on 15/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class SearchPageViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    struct Searching {
        static var animes: [AnimeDisplayInfo] = []
        static var currentText: String = ""
        static var lastPage: Int = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
       
    }
    
    func loadNewSearch(text: String) {
        SearchAnimeService.shared.fetchSearch(text: text.lowercased()) { (searchMain) in
            Searching.lastPage = searchMain.lastPage
            
            if searchMain.results.isEmpty && text.contains(Searching.currentText) {
                print("Search is Empty")
            }
            else {
                Searching.animes = searchMain.results
            }
            
            Searching.currentText = text
            print("New Search: \(Searching.animes.first!.title)")
        }
    }
    
    func loadPageForCurrentSearch(page: Int) {
        guard page <= Searching.lastPage else { return }
        
        SearchAnimeService.shared.fetchSearch(page: page, text: Searching.currentText) { (searchMain) in
            Searching.animes.append(contentsOf: searchMain.results)
        }
    }
}

extension SearchPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.loadNewSearch(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
