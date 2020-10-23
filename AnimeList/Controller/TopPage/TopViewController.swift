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

class TopViewController: UIViewController {
    
    @IBOutlet var topSubtypeDataService: TopSubtypeDataService!
    @IBOutlet weak var topSubtypeCollectionView: UICollectionView!
    
    @IBOutlet weak var topAnimeCollectionView: UICollectionView!
    
    var currentSubtype: AnimeTopSubtype = .bydefault
    var topAnimes: [TopAnime] = [] {
        didSet {
            DispatchQueue.main.async {
                self.topAnimeCollectionView.reloadData()
            }
        }
    }
    
    var didLoadedPages: Int {
        return topAnimes.count / TopAnimeService.numberOfItemsLoad
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topSubtypeCollectionView.dataSource = topSubtypeDataService
        topSubtypeCollectionView.delegate = topSubtypeDataService
        
        topSubtypeDataService.delegate = self
        
        topAnimeCollectionView.delegate = self
        topAnimeCollectionView.dataSource = self
        
        topAnimeCollectionView.scrollsToTop = true
        
        loadAnime(subtype: currentSubtype)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func loadAnime(page: Int = 1, subtype: AnimeTopSubtype) {
        guard page > didLoadedPages else { return }
        
        TopAnimeService.shared.fetchTopAnime(page: page, subtype: subtype) { [weak self] (topAnimes) in
            guard let strongSelf = self else { return }
            
            strongSelf.topAnimes.append(contentsOf: topAnimes)
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
