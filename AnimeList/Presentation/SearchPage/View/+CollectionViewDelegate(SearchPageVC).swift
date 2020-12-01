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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if PageState.isSearching {
            print("isSearching Did Select: \(animes[indexPath.row].title)")
            weak var animeVC = AnimeViewController.initialize(with: animes[indexPath.row].malID)
            guard animeVC != nil else { return }
            self.present(animeVC!, animated: true, completion: nil)
        }
        else {
            let genreID = genres[indexPath.row].rawValue
            print("Genre Did Select: \(genres[indexPath.row])")
            
            let genreVC = storyBoard.instantiateViewController(withIdentifier: "GenreViewController") as! GenreAnimesViewController
            genreVC.initialize(id: genreID)
            genreVC.title = String(describing: genres[indexPath.row])

            self.navigationController?.pushViewController(genreVC, animated: true)
        }
        
    }
}
