//
//  +CollectionViewDataSource(SearchPageVC).swift
//  AnimeList
//
//  Created by Johnny on 16/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

extension SearchPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if PageState.isSearching {
            return self.animes.count
        }
        
        return self.genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if PageState.isSearching {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
            
            cell.configure(with: self.animes[indexPath.row])
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
            
        cell.config(with: genres[indexPath.row])
            
        return cell

    }
}
