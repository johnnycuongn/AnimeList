//
//  +TopAnimeCollectionDataSource(TopViewController).swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

extension TopViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topAnimes.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimeDisplayCell.identifier, for: indexPath) as! AnimeDisplayCell
        
        let topAnimeViewModel =
            viewModel.topAnimes.value[indexPath.row]

        cell.fill(with: topAnimeViewModel, rank: topAnimeViewModel.rank)
        
        return cell
    }
}
