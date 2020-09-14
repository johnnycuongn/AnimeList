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
    
    @IBOutlet weak var topAnimeCollectionView: UICollectionView!
    
    var topAnimes: [TopAnimeInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topSubtypeCollectionView.dataSource = topSubtypeDataService
        topSubtypeCollectionView.delegate = topSubtypeDataService
        
        topAnimeCollectionView.delegate = self
        topAnimeCollectionView.dataSource = self
        
        TopAnimeService.shared.fetchTopAnime(subtype: .bypopularity) { (topAnimes) in
            
            self.topAnimes = topAnimes
            self.topAnimeCollectionView.reloadData()
            
            for anime in topAnimes {
                print("\(anime.malID): \(anime.title) with score: \(anime.score)")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}

extension TopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = topAnimeCollectionView.frame.width / 2.2
        let cellHeight = topAnimeCollectionView.frame.height / 3
        
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
