//
//  TopViewController.swift
//  AnimeList
//
//  Created by Johnny on 13/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    @IBOutlet var topSubtypeDataService: TopSubtypeDataService!
    @IBOutlet weak var topSubtypeCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topSubtypeCollectionView.dataSource = topSubtypeDataService
        topSubtypeCollectionView.delegate = topSubtypeDataService
        
//        TopAnimeService.shared.fetchTopAnime(subtype: .bypopularity) { (topAnimes) in
//            
//            for anime in topAnimes {
//                print("\(anime.malID): \(anime.title) with score: \(anime.score)")
//            }
//            
//        }
    }
    
    
    
    


}
