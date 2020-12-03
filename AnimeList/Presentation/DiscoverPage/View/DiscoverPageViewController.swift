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

class DiscoverPageViewController: UIViewController {

    
    @IBOutlet weak var pageCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var genres = Genre.allCases
    
    override func viewDidLoad() {

        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
       
    }
}

