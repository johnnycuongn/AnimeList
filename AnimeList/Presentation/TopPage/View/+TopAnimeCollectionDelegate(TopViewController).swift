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
        
        let selectedAnime = viewModel.topAnimes.value[indexPath.row]
        let selectedID = selectedAnime.malID
        
        weak var animeVC = AnimeViewController.initialize(with: selectedID)
        guard animeVC != nil else { return }
        self.present(animeVC!, animated: true, completion: nil)
//        self.navigationController?.pushViewController(animeVC!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadNextPage(at: indexPath)
    }
}
