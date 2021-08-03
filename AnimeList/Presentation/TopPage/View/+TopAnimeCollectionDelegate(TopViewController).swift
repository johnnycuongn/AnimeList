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
        viewModel.didSelect(subtype: subtype)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.didSelectAnime(at: indexPath.row)
        
//        let selectedAnime = viewModel.topAnimes.value[indexPath.row]
//        let selectedID = selectedAnime.id
//
//        weak var animeVC = AnimeDetailsViewController.initialize(with: selectedID)
//        guard animeVC != nil else { return }
//        self.present(animeVC!, animated: true, completion: nil)
//        self.navigationController?.pushViewController(animeVC!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadNextPage(at: indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let refresh = self.topAnimeCollectionView.refreshControl, refresh.isRefreshing {
            DispatchQueue.main.async {
                self.topAnimeCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
}
