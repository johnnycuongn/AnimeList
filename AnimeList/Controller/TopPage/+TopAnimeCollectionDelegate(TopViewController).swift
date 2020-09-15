//
//  TopAnimeCollectionDelegate(TopViewController).swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

extension TopViewController: UICollectionViewDelegate, SubtypeDataServiceDelegate {
    
    func didSelect(subtype: AnimeTopSubtype) {
        guard subtype != currentSubtype else { return }
        
        self.topAnimes = []
        self.topSubtypeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        self.currentSubtype = subtype
        loadAnime(subtype: currentSubtype)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Top Anime Select: \(topAnimes[indexPath.row].malID) - \(topAnimes[indexPath.row].title)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let willLoadPosition = topAnimes.count - 8
        
        if indexPath.row == willLoadPosition {
            
            let nextPage = didLoadedPages + 1
            loadAnime(page: nextPage, subtype: currentSubtype)
        }
    }
}
