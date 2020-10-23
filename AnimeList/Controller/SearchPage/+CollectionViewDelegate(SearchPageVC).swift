//
//  +CollectionViewDelegate(SearchPageVC).swift
//  AnimeList
//
//  Created by Johnny on 16/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

extension SearchPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if PageState.isSearching {
            print("isSearching Did Select: \(animes[indexPath.row].title)")
        }
        else {
            let genreID = genres[indexPath.row].rawValue
            print("Genre Did Select: \(genres[indexPath.row])")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let genreVC = storyBoard.instantiateViewController(withIdentifier: "GenreViewController") as! GenreViewController
            genreVC.initialize(id: genreID)

            self.navigationController?.pushViewController(genreVC, animated: true)
        }
        
    }
}
